import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/add-book-float.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/lbrary-image.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/library-page-appbar.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key key, this.library}) : super(key: key);
  final Library library;

  _LibraryPageState createState() => _LibraryPageState(library);
}

class _LibraryPageState extends State<LibraryPage> {
  final Library _library;
  Stream<List<Book>> _bookStream;
  List<Book> _books;

  _LibraryPageState(this._library) {
    _bookStream = libManager.getBooksStream(_library.id);
    _bookStream.listen((data) => _saveBook(data));
  }

  _saveBook(List<Book> data) async {
    _books = data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LibraryPageAppbar(
        title: _library.name,
      ),
      body: Column(
        children: <Widget>[
          LibraryImage(
            image: _library.image,
            tag: _library.id,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
      floatingActionButton: AddBookFloat(
        onPress: null,
      ),
    );
  }
}
