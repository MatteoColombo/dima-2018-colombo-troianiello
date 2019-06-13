import '../../model/book.model.dart';
import '../../model/author.model.dart';
import 'package:flutter/material.dart';
import '../common/description-text.dart';
import './entry-dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../firebase/book-repo.dart';
import 'package:intl/intl.dart';

import '../common/localization.dart';

class BookPage extends StatelessWidget {
  final String isbn;
  final bool addBook;

  BookPage({@required this.isbn,@required this.addBook});
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildImageSection(context, _book),
                  _buildMainInfoSection(context, _book),
                ],
              ),
              _buildSecondSection(context, _book),
            ],
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
            icon: Icon(Icons.done),
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
            onPressed: () => null),
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
            "assets/images/book.jpg",
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

  Widget _buildMainInfoSection(BuildContext context, Book _book) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Localization.of(context).title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(_book.title),
          Divider(
            color: Colors.transparent,
          ),
          Text(
            Localization.of(context).authors,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(children: _buildAuthorsSection(_book.authors)),
        ],
      ),
    );
  }

  Widget _buildDescSection(BuildContext context, Book _book) {
    return new DescriptionTextWidget(text: _book.description);
  }

  Widget _buildSecondSection(BuildContext context, Book _book) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            Text(Localization.of(context).description, style: TextStyle(fontWeight: FontWeight.bold)),
            _buildDescSection(context, _book),
            _buildSecondaryInformation(context, _book),
          ],
        ));
  }

  Widget _buildSecondaryInformation(BuildContext context, Book _book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Localization.of(context).publisher+':',
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
              Localization.of(context).releaseDate+': ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(DateFormat('EEEE, d MMMM y').format(_book.releaseDate)),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Localization.of(context).pages+':',
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
              Localization.of(context).edition+':',
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
              Localization.of(context).price+':',
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
              Localization.of(context).isbn+':',
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
