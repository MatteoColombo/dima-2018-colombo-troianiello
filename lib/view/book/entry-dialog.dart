import 'package:flutter/material.dart';
import '../common/date-picker.dart';
import '../../model/book.model.dart';
import './authors-section.dart';
import './../../firebase/book-repo.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddEntryDialog extends StatefulWidget {
  final Book book;
  AddEntryDialog({@required this.book});
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
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
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _saveChanges(context);
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: _buildBody(context),
            ),
          ),
        ],
      ),
    );
  }

  Future _saveChanges(BuildContext context) async {
    await bookManager.saveReuqest(widget.book);
    Navigator.of(context).pop();
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
        ListTile(
          title: Text(
            "Title",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            decoration: InputDecoration(
              hintText: widget.book.title,
            ),
            initialValue: widget.book.title,
            onSaved: (text) => widget.book.title = text,
          ),
        ),
        AuthorsSectionWidget(
          authors: widget.book.authors,
        ),
        ListTile(
          title: Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            decoration: InputDecoration(
              hintText: widget.book.description,
            ),
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            initialValue: widget.book.description,
            onSaved: (text) => widget.book.description = text,
          ),
        ),
        ListTile(
          title: Text(
            "Publisher",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            decoration: InputDecoration(
              hintText: widget.book.publisher,
            ),
            initialValue: widget.book.publisher,
            onSaved: (text) => widget.book.publisher = text,
          ),
        ),
        ListTile(
          title: Text(
            "Release Date",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: Icon(Icons.today, color: Colors.grey[500]),
          title: DateTimeItem(
            dateTime: widget.book.releaseDate,
            onChanged: (dateTime) =>
                setState(() => widget.book.releaseDate = dateTime),
          ),
        ),
        ListTile(
          title: Text(
            "Pages",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            decoration: InputDecoration(
              hintText: widget.book.pages.toString(),
            ),
            initialValue: widget.book.pages.toString(),
            validator: (String text) {
              if (int.tryParse(text).isNaN)
                return 'Pages must be a number';
              else
                return null;
            },
            keyboardType: TextInputType.number,
            onSaved: (text) => widget.book.pages = int.tryParse(text),
          ),
        ),
        ListTile(
          title: Text(
            "Edition",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            decoration: InputDecoration(
              hintText: widget.book.edition,
            ),
            initialValue: widget.book.edition,
            onSaved: (text) => widget.book.edition = text,
          ),
        ),
        ListTile(
          title: Text(
            "Price",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            decoration: InputDecoration(
              hintText: widget.book.price,
            ),
            initialValue: widget.book.price,
            onSaved: (text) => widget.book.price = text,
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
        alignment: Alignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.book.image,
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
}
