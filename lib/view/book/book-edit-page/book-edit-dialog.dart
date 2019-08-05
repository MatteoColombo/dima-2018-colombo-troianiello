import './image-form-widget.dart';
import '../../common/localization.dart';
import 'package:flutter/material.dart';
import '../../common/date-picker.dart';
import '../../../model/book.model.dart';
import './authors-section.dart';
import './../../../firebase/book-repo.dart';
import '../../common/loading-spinner.dart';
import 'dart:io';

class BookEditDialog extends StatefulWidget {
  final Book book;
  final String isbn;
  BookEditDialog({
    this.isbn,
    this.book,
  }) : assert((isbn != null && book == null) || (isbn == null && book != null));
  @override
  BookEditDialogState createState() => new BookEditDialogState();
}

class BookEditDialogState extends State<BookEditDialog> {
  bool isSaving;
  bool addBook;
  Book book;
  File image;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isSaving = false;
    addBook = widget.book == null;
    if (addBook) {
      this.book = Book();
      book.isbn = widget.isbn;
    } else
      this.book = widget.book.clone();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: addBook
            ? Text("Add new book")
            : Text(Localization.of(context).suggestChanges),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            tooltip: Localization.of(context).done,
            color: Colors.white,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _saveBook(context);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 16.0),
        children: <Widget>[
          isSaving
              ? LoadingSpinner('Saving informations')
              : Form(
                  key: _formKey,
                  child: _buildBody(context),
                ),
        ],
      ),
    );
  }

  Future<void> _saveBook(BuildContext context) async {
    if (book.image == null && image == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Errore"),
            content: new Text("Inserire immagine"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Chiudi"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    if (image != null) book.image = await bookManager.uploadFile(image);
    if (addBook)
      await bookManager.saveBook(book);
    else
      await bookManager.saveRequest(book);
    Navigator.pop(context, book);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageFormSectionWidget(
                book: book,
                saveImage: (File file) {
                  if (file != null) image = file;
                }),
          ],
        ),
        ListTile(
          title: Text(
            Localization.of(context).title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.title != null ? book.title : "",
            validator: (text) => _validator(text),
            onSaved: (text) => book.title = text,
          ),
        ),
        AuthorsSectionWidget(
          authors: book.authors,
        ),
        ListTile(
          title: Text(
            Localization.of(context).description,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            initialValue: book.description != null ? book.description : "",
            validator: (text) => _validator(text),
            onSaved: (text) => book.description = text,
          ),
        ),
        ListTile(
          title: Text(
            Localization.of(context).publisher,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.publisher != null ? book.publisher : "",
            validator: (text) => _validator(text),
            onSaved: (text) => book.publisher = text,
          ),
        ),
        ListTile(
          title: Text(
            Localization.of(context).releaseDate,
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
            Localization.of(context).pages,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.pages != null ? book.pages.toString() : "",
            validator: (text) {
              if (int.tryParse(text).isNaN)
                return Localization.of(context).priceError;
              else
                return null;
            },
            keyboardType: TextInputType.number,
            onSaved: (text) => book.pages = int.tryParse(text),
          ),
        ),
        ListTile(
          title: Text(
            Localization.of(context).edition,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.edition != null ? book.edition : "",
            validator: (text) => _validator(text),
            onSaved: (text) => book.edition = text,
          ),
        ),
        ListTile(
          title: Text(
            Localization.of(context).price,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: TextFormField(
            initialValue: book.price != null ? book.price : "",
            validator: (text) => _validator(text),
            onSaved: (text) => book.price = text,
          ),
        ),
      ],
    );
  }

  String _validator(String text) {
    if (text == "")
      return Localization.of(context).fieldError;
    else
      return null;
  }
}