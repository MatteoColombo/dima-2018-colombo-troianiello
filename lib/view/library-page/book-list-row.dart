import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book.dart';
import 'package:dima2018_colombo_troianiello/view/common/confirm-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/move-book-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/popup-option-enum.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/row-popup-menu.dart';
import 'package:flutter/material.dart';

/// The widget used to display a book in the book list in the library page.
class BookListRow extends StatelessWidget {
  BookListRow(
      {Key key,
      @required this.library,
      @required this.book,
      @required this.isSelected,
      @required this.onSelect,
      @required this.selecting})
      : super(key: key);

  /// The book to be displayed.
  final Book book;

  /// Whether selecting mode is active or not.
  ///
  /// This is used to determine how to color the widget and how to respond to user actions.
  final bool selecting;

  /// Whether this books is selected or not.
  final bool isSelected;

  /// The ID of the library that the book is part of.
  final String library;

  /// The callback function to be triggered when a selection gesture is performed.
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Material(
        elevation: 6,
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          splashColor: Colors.black12,
          highlightColor: Colors.transparent,
          onTap:
              selecting ? () => onSelect(book.isbn) : () => _openBook(context),
          onLongPress: () => onSelect(book.isbn),
          child: Container(
            color: isSelected ? Colors.lightBlue[50] : null,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _generateImage(),
                _generateListTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Returns a widget used to display the book image.s
  Widget _generateImage() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Hero(
          child: CachedNetworkImage(
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            imageUrl: book.image,
            placeholder: (context, _) => Container(
              width: 70,
              height: 70,
              alignment: Alignment.center,
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          tag: book.isbn,
        ),
      ),
    );
  }

  /// Returns a widget with the book information.
  ///
  /// It also display a [RowPopUpMenu].
  Widget _generateListTile() {
    return Expanded(
      child: ListTile(
        title: Text(book.title),
        subtitle: Text(book.publisher),
        trailing: RowPopUpMenu(
          callback: _popupCallback,
          enabled: !selecting,
        ),
      ),
    );
  }

  /// Callback function called by the [RowPopUpMenu]
  ///
  /// It receives a [PopUpOpt] that represents the choice of the user and a [BuildContext]
  void _popupCallback(PopUpOpt choice, BuildContext context) {
    switch (choice) {
      case PopUpOpt.Move:
        _moveBook(context);
        break;
      case PopUpOpt.Delete:
        _deleteBook(context);
        break;
    }
  }

  /// Deletes the book.
  ///
  /// Before deleting the book a [ConfirmDialog] is shown.
  void _deleteBook(BuildContext context) async {
    bool res = await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        question: Localization.of(context).deleteBookQuestion,
      ),
    );
    if (res != null && res) {
      LibProvider.of(context)
          .library
          .deleteBookFromLibrary(book.isbn, library);
    }
  }

  /// Opens the book.
  void _openBook(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookPage(
          isbn: book.isbn,
        ),
      ),
    );
  }

  /// Moves the book to another library.
  ///
  /// It shows a [MoveBookDialog] to determine to which other library the book should be moved.
  void _moveBook(BuildContext context) async {
    String newLib = await showDialog(
      context: context,
      builder: (context) => MoveBookDialog(
        currentLib: library,
      ),
    );
    if (newLib != null) {
      LibProvider.of(context)
          .library
          .moveBooks([book.isbn], library, newLib, context);
      _showMovedSnackBar(context);
    }
  }

  /// Shows a [SnackBar] with a feedback message.
  void _showMovedSnackBar(BuildContext context) {
    SnackBar snackbar = SnackBar(
      content: Text(Localization.of(context).bookMoved),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
