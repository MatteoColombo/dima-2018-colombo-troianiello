import 'package:dima2018_colombo_troianiello/firebase-provider.dart';
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

/// Shows the books that belong to a given library.
class LibraryPage extends StatefulWidget {
  LibraryPage({Key key, this.library, this.context}) : super(key: key);

  /// The library that we want to display.
  final Library library;
  final BuildContext context;

  _LibraryPageState createState() => _LibraryPageState(library, context);
}

class _LibraryPageState extends State<LibraryPage> {
  /// The library that is displayed.
  final Library _library;

  /// A stream that listens for changes on the book list.
  Stream<List<Book>> _bookStream;

  /// The list of books that is currently displayed.
  List<Book> _books;

  /// The list of ISBN codes of book that are currently selected.
  List<String> _selected = [];

  /// The sorting method.
  SortMethods _sort = SortMethods.Title;

  _LibraryPageState(this._library, BuildContext context) {
    _bookStream =
        FireProvider.of(context).library.getBooksStream(_library.id);
    _bookStream.listen((data) => _saveBook(data));
    _loadPreferences();
  }

  /// Loads the shared preferences with the preferred sorting method.
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _sort = SortMethods.values[prefs.getInt("sort") ?? 0];
  }

  /// Updates the state when the stream receives a new book list.
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
      // Hide the floating button is selection mode is active.
      floatingActionButton: _selected.length > 0
          ? null
          : AddBookFloat(
              libraryId: _library.id,
            ),
    );
  }

  /// Callback function called when a row is selected.
  ///
  /// Receives a [String] that represents the ISBN of the book that triggered the callback.
  /// If the book is already selected, it is removed. Otherwise it is added to the list.
  void _onRowSelect(String isbn) {
    if (_selected.contains(isbn)) {
      _selected = _selected.where((s) => s != isbn).toList();
    } else {
      _selected.add(isbn);
    }
    setState(() {});
  }

  /// Callback function called when a button in the AppBar is pressed.
  ///
  /// Its parameters are a [AppBarBtn] representing the user choice and a new [BuildContext].
  /// The [BuildContext] is required because the callback may need to respond with some widgets that require a context containin a Scaffold.
  void _appBarCallback(AppBarBtn choice, BuildContext context) {
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
        _moveSelected(context);
        break;
      case AppBarBtn.Sort:
        _showSortDialog();
        break;
      default:
        break;
    }
  }

  /// Delete selected books and clear the selected list.
  ///
  /// Before deleting a [ConfirmDialog] is shown.
  void _deleteSelected() async {
    bool res = await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        question: Localization.of(context).deleteBooksQuestion,
      ),
    );
    if (res != null && res) {
      FireProvider.of(context)
          .library
          .deleteBooksFromLibrary(_selected, _library.id);
      _selected = [];
    }
  }

  /// Moves selected books to another library.
  ///
  /// Shows a [MoveBookDialog] to ask the user to which library they want to move the books.
  void _moveSelected(BuildContext context) async {
    String newLib = await showDialog(
      context: context,
      builder: (context) => MoveBookDialog(
        currentLib: _library.id,
      ),
    );
    if (newLib != null) {
      FireProvider.of(context)
          .library
          .moveBooks(_selected, _library.id, newLib, context);
      _showMovedSnackBar(context);
      _selected = [];
    }
  }

  /// Shows a snackbar with a feedback message.
  ///
  /// It is shown when book are moved to confirm the action to the user.
  void _showMovedSnackBar(BuildContext context) {
    SnackBar snackbar = SnackBar(
      content: Text(Localization.of(context).bookMoved),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  /// Shows a dialog that asks to the user to choose the sorting method.
  ///
  /// It shows a [SortDialog].
  /// If the user changes its choice, the [SharedPreferences] are updated.
  void _showSortDialog() async {
    SortMethods choice = await showDialog(
        context: context,
        builder: (context) => SortDialog(
              sort: _sort,
            ));
    if (choice != null) {
      setState(() {
        _sort = choice;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("sort", choice.index);
    }
  }
}
