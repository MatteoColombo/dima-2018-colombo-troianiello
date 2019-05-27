import '../../model/book.model.dart';
import '../../model/author.model.dart';
import 'package:flutter/material.dart';
import '../common/description-text.dart';
import './entry-dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../firebase/book-repo.dart';
import 'package:intl/intl.dart';

class BookPage extends StatelessWidget {
  final String isbn;

  BookPage({@required this.isbn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: bookManager.getBook(isbn),
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
                    "images/book-not-found.png",
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
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildImageSection(context, _book),
                  _buildMainInfoSection(_book),
                ],
              ),
              _buildSecondSection(_book),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Book _book) {
    return AppBar(
      title: Text(_book.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.help_outline),
          tooltip: "Suggest changes",
          color: Colors.white,
          onPressed: () => _requestModifyDialog(context, _book),
        ),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context, Book _book) {
    MediaQueryData data = MediaQuery.of(context);
    double _width = data.size.width * 2 / 5;
    double _height = _width * (4 / 3);
    CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: _book.image,
      placeholder: (context, url) => SizedBox(
            width: 50,
            height: 50,
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
              child: CircularProgressIndicator(),
            ),
          ),
      errorWidget: (context, url, error) => Image.asset(
            "images/book.jpg",
          ),
    );
    return GestureDetector(
      onTap: () => _showImage(context, _cachedImage),
      child: Container(
        width: _width,
        height: _height,
        padding: const EdgeInsets.only(top: 8.0),
        child: _cachedImage,
      ),
    );
  }

  Widget _buildMainInfoSection(Book _book) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Title",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(_book.title),
          Divider(
            color: Colors.transparent,
          ),
          Text(
            "Authors",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(children: _buildAuthorsSection(_book.authors)),
        ],
      ),
    );
  }

  Widget _buildDescSection(Book _book) {
    return new DescriptionTextWidget(text: _book.description);
  }

  Widget _buildSecondSection(Book _book) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildDescSection(_book),
            _buildSecondaryInformation(_book),
          ],
        ));
  }

  Widget _buildSecondaryInformation(Book _book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Publisher: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_book.publisher),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Release date: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(DateFormat('EEEE,d MMMM y').format(_book.releaseDate)),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Pages: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_book.pages.toString()),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Edition: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_book.edition),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Price: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_book.price),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "ISBN: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_book.isbn),
          ],
        ),
      ],
    );
  }

  void _showImage(BuildContext context, CachedNetworkImage _image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Container(
                child: _image,
              ),
            ],
          ),
        );
      },
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

  List<Widget> _buildAuthorsSection(List<Author> authors) {
    List<Widget> authorsWidgets = List<Widget>();
    for (Author author in authors) {
      authorsWidgets.add(Text(author.toString()));
    }
    return authorsWidgets;
  }
}
