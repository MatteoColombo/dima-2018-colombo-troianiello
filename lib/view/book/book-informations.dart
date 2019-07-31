import '../../model/book.model.dart';
import '../../model/author.model.dart';
import 'package:flutter/material.dart';
import '../common/description-text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../common/localization.dart';

class BookInformations extends StatelessWidget {
  final Book book;
  BookInformations({@required this.book});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildImageSection(context, book),
                  _buildMainInfoSection(context, book),
                ],
              ),
              _buildSecondSection(context, book),
            ],
          ),
        ],
    );
  }

   Widget _buildImageSection(BuildContext context, Book book) {
    MediaQueryData data = MediaQuery.of(context);
    double _width = data.size.width * 2 / 5;
    double _height = _width * (4 / 3);
    CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: book.image,
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

  Widget _buildMainInfoSection(BuildContext context, Book book) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Localization.of(context).title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(book.title),
          Divider(
            color: Colors.transparent,
          ),
          Text(
            Localization.of(context).authors,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(children: _buildAuthorsSection(book.authors)),
        ],
      ),
    );
  }

  Widget _buildDescSection(BuildContext context, Book book) {
    return new DescriptionTextWidget(text: book.description);
  }

  Widget _buildSecondSection(BuildContext context, Book book) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            Text(Localization.of(context).description,
                style: TextStyle(fontWeight: FontWeight.bold)),
            _buildDescSection(context, book),
            _buildSecondaryInformation(context, book),
          ],
        ));
  }

  Widget _buildSecondaryInformation(BuildContext context, Book book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Localization.of(context).publisher + ':',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(book.publisher),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Localization.of(context).releaseDate + ': ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(DateFormat('EEEE, d MMMM y').format(book.releaseDate)),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Localization.of(context).pages + ':',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(book.pages.toString()),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Localization.of(context).edition + ':',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(book.edition),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Localization.of(context).price + ':',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(book.price),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Localization.of(context).isbn + ':',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(book.isbn),
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

  List<Widget> _buildAuthorsSection(List<Author> authors) {
    List<Widget> authorsWidgets = List<Widget>();
    for (Author author in authors) {
      authorsWidgets.add(Text(author.toString()));
    }
    return authorsWidgets;
  }
}