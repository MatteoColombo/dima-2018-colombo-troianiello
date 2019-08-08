import 'package:dima2018_colombo_troianiello/firebase/book-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/search/search-item.dart';
import "package:flutter/material.dart";

/// Display the results of the book search.
class Search extends StatelessWidget {
  const Search({Key key, this.query}) : super(key: key);

  /// The query search.
  ///
  /// It searchs by book title.
  final String query;

  @override
  Widget build(BuildContext context) {
    // If the query is null return a white page.
    if (query == "") return Center();
    return FutureBuilder(
      future: bookManager.searchBooks(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // When you get results return a list or an image if there is no match.
          if (snapshot.data.length == 0) return _getNothingImg();
          return _getListView(snapshot.data, context);
        } else {
          // While loading return a progess indicator.
          return Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  /// Returns a list where each item is a [SearchItem].
  Widget _getListView(List<Book> books, BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, i) {
        return SearchItem(
          book: books[i],
          key: Key("search${books[i].isbn}"),
        );
      },
    );
  }

  /// Returns an image.
  ///
  /// Used when there is no match for the query.
  Widget _getNothingImg() {
    return Center(
      child: Image.asset(
        "assets/images/stack.png",
        width: 90,
        height: 90,
      ),
    );
  }
}
