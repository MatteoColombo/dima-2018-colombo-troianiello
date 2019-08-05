import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/book-list-row.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  BookList({
    Key key,
    this.books,
    @required this.selected,
    @required this.onSelect,
    @required this.library,
  }) : super(key: key);
  final List<Book> books;
  final String library;
  final List<String> selected;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    if (books == null) {
      return Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
          height: 40,
          width: 40,
        ),
      );
    }

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookListRow(
          key: Key(books[index].isbn),
          book: books[index],
          library: library,
          selecting: selected.length > 0,
          isSelected: selected.contains(books[index].isbn),
          onSelect: onSelect,
        );
      },
    );
  }
}
