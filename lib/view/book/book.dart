import 'package:flutter/material.dart';
import '../common/descriptionTextWidget.dart';
import './entryDialog.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Page(),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildImageSection(context),
                  _buildMainInfoSection(),
                ],
              ),
              _buildSecondSection(),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Book title"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          tooltip: "Modify",
          color: Colors.white,
          onPressed: () => _requestModifyDialog(context),
        ),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    double _width = data.size.width * 2 / 5;
    double _height = _width * (4 / 3);
    CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl:
          'http://goodcomicbooks.com/wp-content/uploads/2011/02/flspcv01.jpg',
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

  Widget _buildMainInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Title",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Titolo'),
          Row(children: <Widget>[
            Text(
              "Authors",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
          Row(
            children: <Widget>[
              Text("Autore 1"),
            ],
          ),
          Row(
            children: <Widget>[
              Text("Autore 2"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescSection() {
    String string =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer laoreet scelerisque mollis. '
        'Duis pharetra ex eget turpis feugiat, in sodales massa condimentum. Nulla ac aliquam augue. Mauris purus magna, sodales in varius ac, '
        'condimentum sit amet felis. Morbi eget ipsum accumsan, placerat mauris quis, feugiat massa. Cras eu sem at mi sagittis malesuada. '
        'Vestibulum nec risus cursus, scelerisque massa iaculis, hendrerit nibh.'
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer laoreet scelerisque mollis. '
        'Duis pharetra ex eget turpis feugiat, in sodales massa condimentum. Nulla ac aliquam augue. Mauris purus magna, sodales in varius ac, '
        'condimentum sit amet felis. Morbi eget ipsum accumsan, placerat mauris quis, feugiat massa. Cras eu sem at mi sagittis malesuada. '
        'Vestibulum nec risus cursus, scelerisque massa iaculis, hendrerit nibh.'
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer laoreet scelerisque mollis. '
        'Duis pharetra ex eget turpis feugiat, in sodales massa condimentum. Nulla ac aliquam augue. Mauris purus magna, sodales in varius ac, '
        'condimentum sit amet felis. Morbi eget ipsum accumsan, placerat mauris quis, feugiat massa. Cras eu sem at mi sagittis malesuada. '
        'Vestibulum nec risus cursus, scelerisque massa iaculis, hendrerit nibh.';
    return new DescriptionTextWidget(text: string);
  }

  Widget _buildSecondSection() {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildDescSection(),
            _buildSecondaryInformation(),
          ],
        ));
  }

  Widget _buildSecondaryInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Publisher:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Editore"),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Release date:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("DD/MM/YYYY"),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Pages:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("00000000"),
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

  void _requestModifyDialog(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new AddEntryDialog();
        },
        fullscreenDialog: true));
  }
}
