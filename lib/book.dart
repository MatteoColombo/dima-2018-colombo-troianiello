import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //double _width = MediaQuery.of(context).size.width * (2 / 5);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Page(),
    );
  }
}

class BookInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * (2 / 5);
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildImageSection(_width),
              _buildMainInfoSection(),
            ],
          ),
          Divider(),
          _buildDescSection(),
          _buildSecondarySection(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Book title"),
      actions: <Widget>[
        IconButton(
          icon: Icon(IconData(0xe3c9, fontFamily: 'MaterialIcons')),
          tooltip: "Modify",
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }

  Container _buildImageSection(double _width) {
    return Container(
        width: _width,
        height: (_width) * (4 / 3),
        decoration: new BoxDecoration(color: Colors.red));
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
          Text("Titolo"),
          Divider(),
          Text(
            "Authors",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("Autore 1"),
          Text("Autore 2"),
        ],
      ),
    );
  }

  Container _buildDescSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer laoreet scelerisque mollis. '
            'Duis pharetra ex eget turpis feugiat, in sodales massa condimentum. Nulla ac aliquam augue. Mauris purus magna, sodales in varius ac, '
            'condimentum sit amet felis. Morbi eget ipsum accumsan, placerat mauris quis, feugiat massa. Cras eu sem at mi sagittis malesuada. '
            'Vestibulum nec risus cursus, scelerisque massa iaculis, hendrerit nibh.',
        softWrap: true,
      ),
    );
  }

  Widget _buildSecondarySection() {
    return Row(
      children: <Widget>[
        Divider(),
        Text("Publisher: editore"),
        Divider(),
        Text("Publish date: DD/MM/YYYY"),
        Divider(),
        Text("Pages: pagine"),
      ],
    );
  }
}

class Page extends StatefulWidget {
  @override
  PageState createState() => new PageState();
}

class PageState extends State<Page> {
  bool _isModify = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildImageSection(data),
              _buildMainInfoSection(),
            ],
          ),
          Divider(),
          _buildDescSection(),
          _buildSecondarySection(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    if (!_isModify) {
      return AppBar(
        title: Text("Book title"),
        actions: <Widget>[
          IconButton(
            icon: Icon(IconData(0xe3c9, fontFamily: 'MaterialIcons')),
            tooltip: "Modify",
            color: Colors.white,
            onPressed: _changePage,
          ),
        ],
      );
    } else {
      return AppBar(
        title: Text("Book title"),
        actions: <Widget>[
          IconButton(
            icon: Icon(IconData(59510, fontFamily: 'MaterialIcons')),
            tooltip: "Done",
            color: Colors.white,
            onPressed: _changePage,
          ),
          IconButton(
            icon: Icon(IconData(58829, fontFamily: 'MaterialIcons')),
            tooltip: "Clear",
            color: Colors.white,
            onPressed: _changePage,
          ),
        ],
      );
    }
  }

  Container _buildImageSection(MediaQueryData data) {
    double _width = data.size.width * 2 / 5;
    double _height = _width * (4 / 3);
    return Container(
        width: _width,
        height: _height,
        decoration: new BoxDecoration(color: Colors.red));
  }

  Widget _buildMainInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Text(
              "Title",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
          Row(children: <Widget>[
            _isModify
                ? TextFormField(
                      decoration: InputDecoration(
                        labelText: "Titolo",
                        ),
                      )
                : Text('Titolo')
          ]),
          Row(children: <Widget> [Text(
            "Authors",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),]),
          Row(children: <Widget> [Text("Autore 1"),],),
          Row(children: <Widget> [Text("Autore 2"),],),
        ],
      ),
    );
  }

  Container _buildDescSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer laoreet scelerisque mollis. '
            'Duis pharetra ex eget turpis feugiat, in sodales massa condimentum. Nulla ac aliquam augue. Mauris purus magna, sodales in varius ac, '
            'condimentum sit amet felis. Morbi eget ipsum accumsan, placerat mauris quis, feugiat massa. Cras eu sem at mi sagittis malesuada. '
            'Vestibulum nec risus cursus, scelerisque massa iaculis, hendrerit nibh.',
        softWrap: true,
      ),
    );
  }

  Widget _buildSecondarySection() {
    return Row(
      children: <Widget>[
        Divider(),
        Text("Publisher: editore"),
        Divider(),
        Text("Publish date: DD/MM/YYYY"),
        Divider(),
        Text("Pages: pagine"),
      ],
    );
  }

  void _changePage() {
    setState(() {
      _isModify = !_isModify;
    });
  }
}
