import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-edit-page/book-edit-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddBook extends StatelessWidget {
  const AddBook({Key key, this.libraryId, this.done}) : super(key: key);
  final String libraryId;
  final Function done;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addBook(context),
      child: Icon(Icons.add),
    );
  }

  _addBook(context) async {
    String isbn =
        await FlutterBarcodeScanner.scanBarcode("#ffffff", "Cancel", true);
    SnackBar snackbar;
    if (isbn != null) {
      RegExp regexp = RegExp("^[0-9]{13,13}");
      if (regexp.hasMatch(isbn)) {
        bool isIn = await libManager.getIfBookAlreadyThere(isbn, libraryId);
        if (!isIn) {
          bool added = await libManager.addBookToUserLibrary(isbn, libraryId);
          if (added) {
            snackbar = SnackBar(
              content: Text("Book added to the library!"),
              action: _snackBarAction(context, isbn),
            );
            done();
          } else {
            Book res = await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => BookEditDialog(
                        isbn: isbn,
                      ),
                  fullscreenDialog: true),
            );
            if (res != null) {
              await libManager.addBookToUserLibrary(isbn, libraryId);
              snackbar = SnackBar(
                content: Text("Book added to the library!"),
                action: _snackBarAction(context, isbn),
              );
              done();
            }
          }
        } else {
          snackbar = SnackBar(
            content: Text("This book is already present in the library"),
            action: _snackBarAction(context, isbn),
          );
        }
      } else {
        snackbar = SnackBar(
          content: Text("A valid ISBN should have 13 digits."),
        );
      }
    }
    Scaffold.of(context).showSnackBar(snackbar);
  }

  Widget _snackBarAction(BuildContext context, String book) {
    return SnackBarAction(
      label: "View",
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => BookPage(
                  isbn: book,
                )),
      ),
    );
  }
}
