import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/popup-option-enum.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/row-popup-menu.dart';
import 'package:flutter/material.dart';

class BookListRow extends StatelessWidget {
  BookListRow(
      {Key key, this.book, this.isSelected, this.onSelect, this.selecting})
      : super(key: key);
  final Book book;
  final bool selecting;
  final bool isSelected;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 8,
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: selecting ? onSelect(book.isbn) : () => _openBook(),
          onLongPress: () => onSelect(book.isbn),
          child: Container(
            color: isSelected ? Colors.lightBlue[50] : null,
            padding: EdgeInsets.all(8),
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
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.publisher),
      trailing: RowPopUpMenu(
        book: book.isbn,
        callback: _popupCallback,
        enabled: !selecting,
      ),
    );
  }

  _popupCallback(PopUpOpt choice, String isbn) {
    switch (choice) {
      case PopUpOpt.Move:
        break;
      case PopUpOpt.Delete:
        break;
    }
  }

  _openBook() {}
}
