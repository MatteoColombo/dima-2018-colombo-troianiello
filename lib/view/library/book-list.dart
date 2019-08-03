import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book.dart';
import 'package:dima2018_colombo_troianiello/view/library/add-book.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BookList extends StatefulWidget {
  BookList({Key key, this.library}) : super(key: key);
  final Library library;

  _BookListState createState() => _BookListState(library);
}

class _BookListState extends State<BookList> {
  Library _library;
  List<Book> _books;

  _BookListState(this._library) {
    _getBooksList();
  }

  _getBooksList() async {
    _books = (await libManager.getBooks(_library));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(_library.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => null,
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () => null,
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 5,
            child: Hero(
              child: _library.image != null
                  ? CachedNetworkImage(
                      height: 200,
                      width: width,
                      alignment: Alignment.center,
                      fit: BoxFit.fitWidth,
                      imageUrl: _library.image,
                    )
                  : Image.asset(
                      "assets/images/library.jpeg",
                      height: 200,
                      width: width,
                      alignment: Alignment.center,
                      fit: BoxFit.fitWidth,
                    ),
              tag: _library.id,
            ),
          ),
          if (_books != null)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: _books.length,
                itemBuilder: (context, i) => _getCard(_books[i]),
              ),
            ),
          if (_books == null)
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: AddBook(
        libraryId: _library.id,
        done: _getBooksList,
      ),
    );
  }

  _getCard(Book book) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BookPage(
                isbn: book.isbn,
                addBook: false,
              ))),
      child: Card(
        elevation: 8,
        margin: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
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
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(book.title),
                    subtitle: Text("${book.publisher}"),
                    trailing: PopupMenuButton(
                      onSelected: (val) => _managePopUpMenu(val, book.isbn),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 0,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(MdiIcons.arrowRightBold),
                                ),
                                Text("Change Library")
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.delete),
                                ),
                                Text("Delete Book")
                              ],
                            ),
                          )
                        ];
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _managePopUpMenu(int selection, String isbn) async {
    switch (selection) {
      case 0:
        break;
      case 1:
        await libManager.deleteBookFromLibrary(isbn, _library.id);
        _getBooksList();
        break;
    }
  }
}
