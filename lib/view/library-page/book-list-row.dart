import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book.dart';
import 'package:dima2018_colombo_troianiello/view/common/confirm-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/move-book-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/popup-option-enum.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/row-popup-menu.dart';
import 'package:flutter/material.dart';

class BookListRow extends StatelessWidget {
  BookListRow(
      {Key key,
      @required this.library,
      @required this.book,
      @required this.isSelected,
      @required this.onSelect,
      @required this.selecting})
      : super(key: key);
  final Book book;
  final bool selecting;
  final bool isSelected;
  final String library;
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

  _generateImage() {
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

  _generateListTile() {
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

  _popupCallback(PopUpOpt choice, BuildContext context) {
    switch (choice) {
      case PopUpOpt.Move:
        _moveBook(context);
        break;
      case PopUpOpt.Delete:
        _deleteBook(context);
        break;
    }
  }

  _deleteBook(BuildContext context) async {
    bool res = await ConfirmDialog()
        .instance(context, Localization.of(context).deleteBookQuestion);
    if (res != null && res) {
      libManager.deleteBookFromLibrary(book.isbn, library);
    }
  }

  _openBook(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookPage(
          isbn: book.isbn,
        ),
      ),
    );
  }

  _moveBook(BuildContext context) async {
    String newLib = await showDialog(
      context: context,
      builder: (context) => MoveBookDialog(
        currentLib: library,
      ),
    );
    if (newLib != null) {
      libManager.moveBooks([book.isbn], library, newLib);
      _showMovedSnackBar(context);
    }
  }

  _showMovedSnackBar(BuildContext context) {
    SnackBar snackbar = SnackBar(
      content: Text(Localization.of(context).bookMoved),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
