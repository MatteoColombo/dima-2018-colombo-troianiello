import '../../model/book.model.dart';
import '../../model/author.model.dart';
import 'package:flutter/material.dart';
import '../common/description-text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../common/localization.dart';

///Shows all informations of the given [Book].
///
///Creates a [ListView], containing a [CachedNetworkImage] and all textual informations.
class BookInformations extends StatelessWidget {
  ///The given [Book]
  final Book book;

  ///Constructor of BookInformations
  ///
  ///Requires a [book], whose informations will be shown.
  BookInformations({@required this.book}) : assert(book != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }

  ///Returns the image section of this page.
  ///
  ///Creates a [Widget], containing a [CachedNetworkImage] associated to the URL of this [book].
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

  ///Returns a section containg the title and authors of this book.
  ///
  ///The main section is a [Column], containing several [Text] widgets.
  Widget _buildMainInfoSection(BuildContext context, Book book) {
    return Container(
      width: MediaQuery.of(context).size.width * 3 / 5,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Localization.of(context).title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
          Text(
            book.title,
          ),
          Divider(
            color: Colors.transparent,
          ),
          Text(
            Localization.of(context).authors,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
          ..._buildAuthorsSection(book.authors),
        ],
      ),
    );
  }

  ///Returns a section containing the description of this book.
  ///
  ///Returns a [DescriptionTextWidget], that show the [text]
  ///in a contracted form or a extended form.
  Widget _buildDescSection(BuildContext context, Book book) {
    return new DescriptionTextWidget(text: book.description);
  }

  ///Returns a section containing the description and other secondary informations of this book.
  ///
  ///Returns a [Column], containig the [Text] of [book.descripton],
  ///[book.publisher], [book.releaseDate], [book.edition], [book.price],
  ///[book.pages], [book.isbn].
  Widget _buildSecondSection(BuildContext context, Book book) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            Text(Localization.of(context).description,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
            _buildDescSection(context, book),
            ..._buildSecondaryInformation(context, book),
          ],
        ));
  }

  ///Returns a list of widgets associated to the secondary informations of this book.
  ///
  ///Returns a [List] of [Widget], containig the [Text] of [book.publisher],
  ///[book.releaseDate], [book.edition], [book.price], [book.pages], [book.isbn].
  List<Widget> _buildSecondaryInformation(BuildContext context, Book book) {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            Localization.of(context).publisher + ':',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
          Text(book.isbn),
        ],
      ),
    ];
  }

  ///Shows a dialog that contains a large sized version of the cover.
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

  ///Returns a list of widgets associated to authors of this book.
  ///
  ///Returns a [List] of [Text].
  List<Widget> _buildAuthorsSection(List<Author> authors) {
    List<Widget> authorsWidgets = List<Widget>();
    for (Author author in authors) {
      authorsWidgets.add(Text(author.toString()));
    }
    return authorsWidgets;
  }
}
