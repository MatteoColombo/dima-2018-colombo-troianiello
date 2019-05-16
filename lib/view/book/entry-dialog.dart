import 'package:flutter/material.dart';
import '../common/date-picker.dart';
import '../../model/book.model.dart';
import './authors-section.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddEntryDialog extends StatefulWidget {
  final Book book;

  AddEntryDialog({@required this.book});
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Suggest changes'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            tooltip: "Done",
            color: Colors.white,
            onPressed: () => null,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildImageSection(context),
          ],
        ),
        Text(
          "Title: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: widget.book.title,
          ),
        ),
        AuthorsSectionWidget(
          authors: widget.book.authors,
        ),
        Text(
          "Description: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.book.description,
          ),
          maxLines: 5,
          keyboardType: TextInputType.multiline,
        ),
        Divider(color: Colors.transparent),
        Text(
          "Publisher: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.book.publisher,
          ),
        ),
        Text(
          "Release Date: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: new Icon(Icons.today, color: Colors.grey[500]),
          title: new DateTimeItem(
            dateTime: widget.book.releaseDate,
            onChanged: (dateTime) => setState(() => null),
          ),
        ),
        Text(
          "Pages: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.book.pages.toString(),
          ),
        ),
        Text(
          "Edition: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.book.edition,
          ),
        ),
        Text(
          "Price: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.book.price,
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    double _width = data.size.width * 2 / 5;
    double _height = _width * (4 / 3);
    return Container(
      width: _width,
      height: _height,
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.book.image,
            alignment: Alignment.center,
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.white30,
            child: Icon(Icons.photo_camera),
          ),
        ],
      ),
    );
  }

  /*Widget _buildAuthorsSection() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Authors: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () => null,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Autore1",
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => null,
            ),
          ],
        ),
      ],
    );
  }*/
}
