import 'package:dima2018_colombo_troianiello/firebase-provider.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-edit-page/book-edit-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-informations.dart';
import './reviews-page/reviews-widget.dart';
import '../../model/book.model.dart';
import 'package:flutter/material.dart';
import './book-edit-page/book-edit-dialog.dart';
import '../common/localization.dart';

///Generates the page of a given [Book], that allows to view and edit the informations.
///
///Connectes to Firestore DB to retrive this [Book] and creates a [TabBarView], containg the main information of this book,
///and a [BookEditDialog], that allows to edit these informations.
class BookPage extends StatelessWidget {
  ///The identifier of the book.
  final String isbn;

  ///Constructor of BookPage
  ///
  ///Requires a [isbn], the identifier of this book.
  BookPage({@required this.isbn}) : assert(isbn != null);

  //Retreives the [Book] using a [FutureBuilder].
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireProvider.of(context).book.getBook(isbn),
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

  ///Describes the part of the user interface represented by this widget and is called by [build(context)]
  ///
  ///Given a [BuildContext] and a [Book], creates a [TabBarView] that shows all the informations and reviews of this book.
  Widget _build(BuildContext context, Book _book) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(context, _book),
        body: TabBarView(
          children: <Widget>[
            BookInformations(book: _book),
            ReviewsWidget(
              isbn: _book.isbn,
            ),
          ],
        ),
      ),
    );
  }

  ///Creates the [AppBar] of this page.
  AppBar _buildAppBar(BuildContext context, Book _book) {
    List<Widget> actions;
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
        onPressed: () => _requestModifyDialog(context, _book),
      ),
    ];
    return AppBar(
      title: Text(_book.title),
      actions: <Widget>[
        ...actions,
      ],
      bottom: TabBar(
        tabs: [
          Tab(
              icon: Icon(
            Icons.book,
          )),
          Tab(
              icon: Icon(
            Icons.comment,
          )),
        ],
      ),
    );
  }

  ///Opens the dialog that allows to edit the informations of this [Book].
  ///
  ///This dialog opened is a [FullScreenDialog] type.
  void _requestModifyDialog(BuildContext context, Book _book) {
    Navigator.of(context).push(MaterialPageRoute<Book>(
        builder: (BuildContext context) {
          return BookEditDialog(
            book: _book,
          );
        },
        fullscreenDialog: true));
  }
}
