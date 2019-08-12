import 'package:dima2018_colombo_troianiello/firebase-provider.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-edit-page/book-edit-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/book/book.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

/// A Floating Action Button used to add a book the the library.
class AddBookFloat extends StatelessWidget {
  AddBookFloat({Key key, @required this.libraryId}) : super(key: key);

  /// The library to which the user wants to add a book.
  final String libraryId;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addBook(context),
      child: Icon(Icons.add),
    );
  }

  /// Handles the add of a new book to the library.
  ///
  /// It uses a [FlutterBarcodeScanner] to get the ISBN code.
  /// The result is checked to verify that it is a valid 13 digits ISBN,
  /// then if the book is not in the library and it exists in the database,
  /// it is added to the library.
  /// If the book doesn't exist, a page to manually insert book data in shown,
  /// A [SnackBar] is shown to notify the user of the result of the operation.
  _addBook(context) async {
    String isbn = await FireProvider.of(context).scanner.getISBN(context);
    SnackBar snackbar;
    // If the user cancelled the operation or if the ISBN in null, do nothing.
    if (isbn != null && isbn != "") {
      RegExp regexp = RegExp("^[0-9]{13,13}");
      // We use a regexp to check if the ISBN is valid.
      if (regexp.hasMatch(isbn)) {
        bool isIn = await FireProvider.of(context)
            .library
            .getIfBookAlreadyThere(isbn, libraryId);
        // If the book is already in the library, show a message.
        if (!isIn) {
          bool added = await FireProvider.of(context)
              .library
              .addBookToUserLibrary(isbn, libraryId, context);
          // Try to add a book, if it doesn't exist ask the user to insert data.
          if (added) {
            snackbar = SnackBar(
              content: Text(Localization.of(context).bookAddedConfirm),
              action: _snackBarAction(context, isbn),
            );
          } else {
            Book res = await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => BookEditDialog(
                        isbn: isbn,
                      ),
                  fullscreenDialog: true),
            );
            if (res != null) {
              await FireProvider.of(context)
                  .library
                  .addBookToUserLibrary(isbn, libraryId, context);
              snackbar = SnackBar(
                content: Text(Localization.of(context).bookAddedConfirm),
                action: _snackBarAction(context, isbn),
              );
            } else
              return;
          }
        } else {
          snackbar = SnackBar(
            content: Text(Localization.of(context).bookAlreadyPresent),
            action: _snackBarAction(context, isbn),
          );
        }
      } else {
        snackbar = SnackBar(
          content: Text(Localization.of(context).invalidISBN),
        );
      }
      // Show a SnackBar with a feedback message.
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  /// Shows a [SnackBar] with a feedback message.
  ///
  /// The [SkanckBar] requires a [BuildContext] with a Scaffold.
  Widget _snackBarAction(BuildContext context, String book) {
    return SnackBarAction(
      label: Localization.of(context).view,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => BookPage(
                  isbn: book,
                )),
      ),
    );
  }
}
