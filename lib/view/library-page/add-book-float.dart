import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-edit-page/book-edit-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/book/book.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddBookFloat extends StatelessWidget {
  AddBookFloat({Key key, @required this.libraryId}) : super(key: key);
  final String libraryId;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addBook(context),
      child: Icon(Icons.add),
    );
  }

  _addBook(context) async {
    String isbn = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", Localization.of(context).cancel, true);
    SnackBar snackbar;
    if (isbn != null && isbn != "") {
      RegExp regexp = RegExp("^[0-9]{13,13}");
      if (regexp.hasMatch(isbn)) {
        bool isIn = await libManager.getIfBookAlreadyThere(isbn, libraryId);
        if (!isIn) {
          bool added = await libManager.addBookToUserLibrary(isbn, libraryId);
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
              await libManager.addBookToUserLibrary(isbn, libraryId);
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
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

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
