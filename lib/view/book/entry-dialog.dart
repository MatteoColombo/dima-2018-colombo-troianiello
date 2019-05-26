import 'package:dima2018_colombo_troianiello/view/book/image-form-widget.dart';
import 'package:flutter/material.dart';
import '../common/date-picker.dart';
import '../../model/book.model.dart';
import './authors-section.dart';
import './../../firebase/book-repo.dart';

class AddEntryDialog extends StatefulWidget {
  final Book book;
  AddEntryDialog({@required this.book});
  @override
  AddEntryDialogState createState() => new AddEntryDialogState(book);
}

class AddEntryDialogState extends State<AddEntryDialog> {
  Book book;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  AddEntryDialogState(Book book) {
    this.book = book.clone();
  }

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
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Future _saveChanges(BuildContext context) async {
    await bookManager.saveReuqest(book);
    Navigator.of(context).pop();
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageFormSectionWidget(book: book,),
          ],
        ),
        ListTile(
          title: Text(
            "Title",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.title,
            validator: (text) => _validator(text),
            onSaved: (text) => book.title = text,
          ),
        ),
        AuthorsSectionWidget(
          authors: book.authors,
        ),
        ListTile(
          title: Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            initialValue: book.description,
            validator: (text) => _validator(text),
            onSaved: (text) => book.description = text,
          ),
        ),
        ListTile(
          title: Text(
            "Publisher",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.publisher,
            validator: (text) => _validator(text),
            onSaved: (text) => book.publisher = text,
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
            dateTime: book.releaseDate,
            onChanged: (dateTime) =>
                setState(() => book.releaseDate = dateTime),
          ),
        ),
        ListTile(
          title: Text(
            "Pages",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.pages.toString(),
            validator: (text) {
              if (int.tryParse(text).isNaN)
                return 'Pages must be a number';
              else
                return null;
            },
            keyboardType: TextInputType.number,
            onSaved: (text) => book.pages = int.tryParse(text),
          ),
        ),
        ListTile(
          title: Text(
            "Edition",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.edition,
            validator: (text) => _validator(text),
            onSaved: (text) => book.edition = text,
          ),
        ),
        ListTile(
          title: Text(
            "Price",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.price,
            validator: (text) => _validator(text),
            onSaved: (text) => book.price = text,
          ),
        ),
      ],
    );
  }
  
  String _validator(String text) {
    if (text == "")
      return 'This field cannot be empty';
    else
      return null;
  }
}
