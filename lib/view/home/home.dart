import 'package:dima2018_colombo_troianiello/firebase/auth.dart';
import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/appbar-buttons-enum.dart';
import 'package:dima2018_colombo_troianiello/view/common/confirm-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/home/home-appbar.dart';
import 'package:dima2018_colombo_troianiello/view/home/home-drawer.dart';
import 'package:dima2018_colombo_troianiello/view/home/library-list.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/new-library.dart';
import 'package:dima2018_colombo_troianiello/view/search/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseUser _user;
  String _initials;
  List<String> _selectedLibs;
  Stream<List<Library>> _libstream;
  List<Library> _libraries;
  bool _searching;
  TextEditingController _searchController;
  String _searchQuery;

  _HomeState()
      : _searching = false,
        _searchQuery = "",
        _selectedLibs = [],
        _searchController = TextEditingController(text: "") {
    _getUser();
    _libstream = libManager.getLibraryStream();
    _libstream.listen((data) => _setLibraries(data));
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _searchQuery = "";
        });
      } else {
        setState(() {
          _searchQuery = _searchController.text;
        });
      }
    });
  }

  _setLibraries(List<Library> libs) {
    setState(() {
      _libraries = libs;
    });
  }

  _getUser() {
    _user = authService.getUser();
    List<String> name = _user.displayName.split(" ");
    _initials = name.first.substring(0, 1).toUpperCase() +
        name.last.substring(0, 1).toUpperCase();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(
        searchController: _searchController,
        selecting: _selectedLibs.length > 0,
        selectedCount: _selectedLibs.length,
        callback: _appBarButtonCallback,
        searching: _searching,
      ),
      drawer: HomeDrawer(
        initials: _initials,
        user: _user,
      ),
      body: _searching
          ? Search(
              query: _searchQuery,
            )
          : LibraryList(
              selected: _selectedLibs,
              onSelect: _itemSelection,
              libraries: _libraries,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => NewLibrary()),
        child: Icon(Icons.add),
      ),
    );
  }

  _itemSelection(String id) {
    print(id);
    if (_selectedLibs.contains(id))
      _selectedLibs = _selectedLibs.where((s) => s != id).toList();
    else
      _selectedLibs.add(id);
    setState(() {});
  }

  _appBarButtonCallback(AppBarBtn choice, BuildContext context) {
    switch (choice) {
      case AppBarBtn.Clear:
        _selectedLibs = [];
        _searching = false;
        _searchController.clear();
        setState(() {});
        break;
      case AppBarBtn.DeleteAll:
        _deleteSelected(context);
        break;
      case AppBarBtn.Search:
        _searching = true;
        setState(() {});
        break;
      case AppBarBtn.SelectAll:
        _selectedLibs = [..._libraries.map((l) => l.id)];
        print(_selectedLibs);
        setState(() {});
        break;
      default:
        break;
    }
  }

  _deleteSelected(BuildContext context) async {
    bool res = await ConfirmDialog()
        .instance(context, Localization.of(context).deleteSelectedLibsConfirm);
    if (res) {
      libManager.deleteSelectedLibraries(_selectedLibs);
      _selectedLibs = [];
      setState(() {});
    }
  }
}
