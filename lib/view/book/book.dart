import 'package:dima2018_colombo_troianiello/view/book/book-informations.dart';

import './reviews-widget.dart';
import '../../model/book.model.dart';
import 'package:flutter/material.dart';
import './entry-dialog.dart';
import '../../firebase/book-repo.dart';
import '../common/localization.dart';

class BookPage extends StatelessWidget {
  final String isbn;
  final bool addBook;

  BookPage({@required this.isbn, @required this.addBook});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bookManager.getBook(isbn),
      builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
        if (!snapshot.hasData)
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        else {
          if (snapshot.data.isEmpty())
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Container(
                  padding: EdgeInsets.all(60.0),
                  child: Image.asset(
                    "assets/images/book-not-found.png",
                  ),
                ),
              ),
            );
          else
            return _build(context, snapshot.data);
        }
      },
    );
  }

  Widget _build(BuildContext context, Book _book) {
    return Scaffold(
      appBar: _buildAppBar(context, _book),
      body: PageView(
        children: <Widget>[
          BookInformations(book: _book),
          ReviewsWidget(
            isbn: _book.isbn,
            addBook:addBook,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Book _book) {
    List<Widget> actions;
    if (addBook)
      actions = [
        IconButton(
            icon: Icon(Icons.done,),
            tooltip: Localization.of(context).done,
            color: Colors.white,
            onPressed: () => null),
      ];
    else
      actions = [
        IconButton(
          icon: Icon(Icons.library_books),
          tooltip: "",
          color: Colors.white,
          onPressed: () => null,
        ),
        IconButton(
            icon: Icon(Icons.help_outline),
            tooltip: Localization.of(context).suggestChanges,
            color: Colors.white,
            onPressed: () => _requestModifyDialog(context, _book)),
      ];
    return AppBar(
      title: Text(_book.title),
      actions: <Widget>[
        ...actions,
      ],
    );
  }

  void _requestModifyDialog(BuildContext context, Book _book) {
    Navigator.of(context).push(MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return AddEntryDialog(
            book: _book,
          );
        },
        fullscreenDialog: true));
  }
}
