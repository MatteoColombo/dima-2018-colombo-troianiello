import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/book-list-row.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/sort-books-enum.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  BookList({
    Key key,
    this.books,
    @required this.selected,
    @required this.onSelect,
    @required this.library,
    @required this.sort
  }) : super(key: key);
  final List<Book> books;
  final String library;
  final List<String> selected;
  final Function onSelect;
  final SortMethods sort;

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
    _sortBooks();
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

  _sortBooks(){
    switch(sort){
      case SortMethods.Title:
        books.sort((a,b)=>a.title.compareTo(b.title));
        break;
      case SortMethods.TitleReverse:
        books.sort((a,b)=> -a.title.compareTo(b.title));
        break;
      case SortMethods.Newest:
        books.sort((a,b)=>-a.releaseDate.compareTo(b.releaseDate));
        break;
      case SortMethods.Oldest:
        books.sort((a,b)=>a.releaseDate.compareTo(b.releaseDate));
        break;
      default:break;
    }
  }
}
