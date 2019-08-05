import 'package:dima2018_colombo_troianiello/firebase/book-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/search/search-item.dart';
import "package:flutter/material.dart";

class Search extends StatelessWidget {
  const Search({Key key, this.query}) : super(key: key);
  final String query;

  @override
  Widget build(BuildContext context) {
    if (query == "") return Center();
    return FutureBuilder(
      future: bookManager.searchBooks(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) return _getNothingImg();
          return _getListView(snapshot.data, context);
        } else {
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

  _getListView(List<Book> books, BuildContext context) {
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

  _getNothingImg() {
    return Center(
      child: Image.asset(
        "assets/images/stack.png",
        width: 90,
        height: 90,
      ),
    );
  }
}
