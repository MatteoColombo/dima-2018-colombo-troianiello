import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  SearchItem({
    Key key,
    @required this.book,
  }) : super(key: key);
  final Book book;

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
          onTap: () => _openBook(context),
          child: Container(
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
      ),
    );
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
}
