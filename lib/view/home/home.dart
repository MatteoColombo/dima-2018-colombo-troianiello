import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/appbar-buttons-enum.dart';
import 'package:dima2018_colombo_troianiello/view/common/confirm-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/home/home-appbar.dart';
import 'package:dima2018_colombo_troianiello/view/home/home-drawer.dart';
import 'package:dima2018_colombo_troianiello/view/home/library-list.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/new-library.dart';
import 'package:dima2018_colombo_troianiello/view/search/search.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';
import 'package:flutter/material.dart';

/// The main page of the application.
///
/// It shows the list of the libraries and gives the possibility to add, select and delete them.
/// It also allows the user to search within the list of all the books in the database.
class Home extends StatefulWidget {
  Home(this.context);
  final BuildContext context;
  _HomeState createState() => _HomeState(context);
}

class _HomeState extends State<Home> {
  /// It represents the user.
  User _user;

  /// A list constaing the IDs of selected libraries.
  List<String> _selectedLibs;

  /// Retrieves book from the database with realtime updates.
  Stream<List<Library>> _libstream;

  /// The list of currently available libraries.
  List<Library> _libraries;

  /// True if searching.
  bool _searching;

  /// The text controller used by the text field in the search bar.
  TextEditingController _searchController;

  /// The current search query.
  String _searchQuery;

  _HomeState(BuildContext context)
      : _searching = false,
        _searchQuery = "",
        _selectedLibs = [],
        _searchController = TextEditingController(text: "") {
    _getUser(context);

    // Gets libraries and adds listener so that each time the list updates the UI is updated.
    _libstream = LibProvider.of(context).library.getLibraryStream(_user.id);
    _libstream.listen((data) => _setLibraries(data));

    // Adds a listener to the search text input controller so that we can update the search query.
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

  /// Used to save updated libraries.
  ///
  /// Receives a [List<Library>] and stores it.
  void _setLibraries(List<Library> libs) {
    setState(() {
      _libraries = libs;
    });
  }

  /// Saves the current user.
  ///
  /// Asks to the Authentication repository for the current user and stores it as a [FirebaseUser].
  /// Saves the users initials so that they can be showed in the Drawer.
  void _getUser(BuildContext context) {
    _user = LibProvider.of(context).auth.getUser();
  }

  /// Dispose of the search controller when this widget is terminated.
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
        user: _user,
      ),
      // If searching show the search list, otherwiser show the library list.
      body: _searching
          ? Search(
              query: _searchQuery,
            )
          : LibraryList(
              selected: _selectedLibs,
              onSelect: _itemSelection,
              libraries: _libraries,
            ),
      // Hide the floating action button if searching or selecting.
      floatingActionButton: _selectedLibs.length > 0 || _searching
          ? null
          : FloatingActionButton(
              onPressed: () => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => NewLibrary()),
              child: Icon(Icons.add),
            ),
    );
  }

  /// Updates the list of selected libraries.
  ///
  /// Receives a [String] representing the id of the library that triggered the method.
  /// If the library is already selected, unselect it, otherwiser add it to the list.
  void _itemSelection(String id) {
    if (_selectedLibs.contains(id))
      _selectedLibs = _selectedLibs.where((s) => s != id).toList();
    else
      _selectedLibs.add(id);
    setState(() {});
  }

  /// Answers to appbar buttons taps.
  ///
  /// Receives a [AppBarBtn] and a [BuildContext].
  /// The [AppBarBtn] parameter represents the choosen action.
  /// The [BuildContext] is used to create a [Dialog] or to show a [Scaffold] when a [BuildContext] with a Scaffold is required.
  /// We need to use another context and not the one of this Stateful Widget because this context wouldn't contain the Scaffold as it is defined in this class.
  void _appBarButtonCallback(AppBarBtn choice, BuildContext context) {
    switch (choice) {
      // Clear the selected list, clear the search box and set searching to false.
      case AppBarBtn.Clear:
        _selectedLibs = [];
        _searching = false;
        _searchController.clear();
        setState(() {});
        break;
      case AppBarBtn.DeleteAll:
        _deleteSelected(context);
        break;
      // Set searching true.
      case AppBarBtn.Search:
        _searching = true;
        setState(() {});
        break;
      // Get all the library IDs and add them to the selected list.
      case AppBarBtn.SelectAll:
        _selectedLibs = [..._libraries.map((l) => l.id)];
        setState(() {});
        break;
      default:
        break;
    }
  }

  // Delete selected libraries and then clear the selected list.
  _deleteSelected(BuildContext context) async {
    bool res = await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        question: Localization.of(context).deleteSelectedLibsConfirm,
      ),
    );

    if (res) {
      LibProvider.of(context).library.deleteSelectedLibraries(_selectedLibs);
      _selectedLibs = [];
      setState(() {});
    }
  }
}
