import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book.dart';
import 'package:flutter/material.dart';

/// Used to represent an item of the search page.
class SearchItem extends StatelessWidget {
  SearchItem({
    Key key,
    @required this.book,
  }) : super(key: key);

  /// The book to be displayed.
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

  /// Returns a widget to display the picture of the book.
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

  /// Returns a widget with the information of the book.
  Widget _generateListTile() {
    return Expanded(
      child: ListTile(
        title: Text(book.title),
        subtitle: Text(book.publisher),
      ),
    );
  }

  /// Method used to show the book page with all the information.
  void _openBook(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookPage(
          isbn: book.isbn,
        ),
      ),
    );
  }
}
