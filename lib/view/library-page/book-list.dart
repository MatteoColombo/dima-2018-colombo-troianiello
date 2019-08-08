import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/book-list-row.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/sort-books-enum.dart';
import 'package:flutter/material.dart';

/// Widget used to display the book list in the library page.
class BookList extends StatelessWidget {
  BookList(
      {Key key,
      this.books,
      @required this.selected,
      @required this.onSelect,
      @required this.library,
      @required this.sort})
      : super(key: key);

  /// List of books to be displayed.
  final List<Book> books;

  /// Id of the library.
  final String library;

  /// List of ISBN codes that represent the selected books.
  final List<String> selected;

  /// Callback function called when a book is selected.
  final Function onSelect;

  /// User preferred sorting method.
  final SortMethods sort;

  /// Method used to render the widget.
  ///
  /// If the book list is null it displays a loading indicator.
  /// If the book list is not null, it displays a list of [BookListRow] items.
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

  /// Method used to sort books before displaying them.
  void _sortBooks() {
    switch (sort) {
      case SortMethods.Title:
        books.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortMethods.TitleReverse:
        books.sort((a, b) => -a.title.compareTo(b.title));
        break;
      case SortMethods.Newest:
        books.sort((a, b) => -a.releaseDate.compareTo(b.releaseDate));
        break;
      case SortMethods.Oldest:
        books.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
        break;
      default:
        break;
    }
  }
}
