import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/appbar-buttons-enum.dart';
import 'package:dima2018_colombo_troianiello/view/common/confirm-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/add-book-float.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/book-list.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/lbrary-image.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/library-page-appbar.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/move-book-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/sort-books-enum.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/sort-dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key key, this.library}) : super(key: key);
  final Library library;

  _LibraryPageState createState() => _LibraryPageState(library);
}

class _LibraryPageState extends State<LibraryPage> {
  final Library _library;
  Stream<List<Book>> _bookStream;
  List<Book> _books;
  List<String> _selected = [];
  SortMethods _sort = SortMethods.Title;

  _LibraryPageState(this._library) {
    _bookStream = libManager.getBooksStream(_library.id);
    _bookStream.listen((data) => _saveBook(data));
    _loadPreferences();
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _sort = SortMethods.values[prefs.getInt("sort") ?? 0];
  }

  _saveBook(List<Book> data) async {
    _books = data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LibraryPageAppbar(
        title: _library.name,
        callback: _appBarCallback,
        selectedCount: _selected.length,
        selecting: _selected.length > 0,
      ),
      body: Column(
        children: <Widget>[
          LibraryImage(
            image: _library.image,
            tag: _library.id,
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: BookList(
              sort: _sort,
              library: _library.id,
              books: _books,
              onSelect: _onRowSelect,
              selected: _selected,
            ),
          )
        ],
      ),
      floatingActionButton: AddBookFloat(
        libraryId: _library.id,
      ),
    );
  }

  _onRowSelect(String isbn) {
    if (_selected.contains(isbn)) {
      _selected = _selected.where((s) => s != isbn).toList();
    } else {
      _selected.add(isbn);
    }
    setState(() {});
  }

  _appBarCallback(AppBarBtn choice, BuildContext newContext) {
    switch (choice) {
      case AppBarBtn.Clear:
        setState(() {
          _selected = [];
        });
        break;
      case AppBarBtn.SelectAll:
        setState(() {
          _selected = _books.map((b) => b.isbn);
        });
        break;
      case AppBarBtn.DeleteAll:
        _deleteSelected();
        break;
      case AppBarBtn.Move:
        _moveSelected(newContext);
        break;
      case AppBarBtn.Sort:
        _showSortDialog();
        break;
      default:
        break;
    }
  }

  _deleteSelected() async {
    bool res = await ConfirmDialog()
        .instance(context, Localization.of(context).deleteBooksQuestion);
    if (res != null && res) {
      libManager.deleteBooksFromLibrary(_selected, _library.id);
      _selected = [];
    }
  }

  _moveSelected(BuildContext newContext) async {
    String newLib = await showDialog(
      context: context,
      builder: (context) => MoveBookDialog(
        currentLib: _library.id,
      ),
    );
    if (newLib != null) {
      libManager.moveBooks(_selected, _library.id, newLib);
      _showMovedSnackBar(newContext);
      _selected = [];
    }
  }

  _showMovedSnackBar(BuildContext newContext) {
    SnackBar snackbar = SnackBar(
      content: Text(Localization.of(context).bookMoved),
    );
    Scaffold.of(newContext).showSnackBar(snackbar);
  }

  _showSortDialog() async {
    SortMethods choice = await showDialog(
        context: context,
        builder: (context) => SortDialog(
              sort: _sort,
            ));
    if (choice != null) {
      setState(() {
        _sort = choice;
      });
    }
  }
}
