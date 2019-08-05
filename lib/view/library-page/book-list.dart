import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/book-list-row.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  const BookList({Key key, this.books, this.selected, this.onSelect})
      : super(key: key);
  final List<Book> books;
  final List<String> selected;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookListRow(
          key: Key(books[index].isbn),
          book: books[index],
          selecting: selected.length > 0,
          isSelected: selected.contains(books[index].isbn),
        );
      },
    );
  }
}
