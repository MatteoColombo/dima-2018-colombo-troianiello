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
  bool addBook;
  Book book;
  File image;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final FocusNode descriptionFocus=FocusNode();
  final FocusNode publisherFocus=FocusNode();
  final FocusNode priceFocus=FocusNode();
  final FocusNode pagesFocus=FocusNode();
  final FocusNode editionFocus=FocusNode();


  @override
  void initState() {
    super.initState();
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
            ? Text(Localization.of(context).addNewBook)
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
        padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
        children: <Widget>[
              Form(
                  key: _formKey,
                  child: _buildBody(context),
                ),
        ],
      ),
    );
  }

  Future<void> _saveBook(BuildContext context) async {
    if (book.image == null && image == null) {
      _showDialogErrorImage(context);
      return;
    }
    _showDialogSaving(context);
    if (image != null)
      book.image = await bookManager.uploadFile(image, !addBook);
    if (addBook)
     await bookManager.saveBook(book);
    else
      bookManager.saveRequest(book);
    Navigator.pop(context);
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
        TextFormField(
          autofocus: true,
          onFieldSubmitted: (v){
                FocusScope.of(context).requestFocus(descriptionFocus);
          },
          decoration:
              InputDecoration(labelText: Localization.of(context).title),
          initialValue: book.title != null ? book.title : "",
          validator: (text) => _validator(text),
          onSaved: (text) => book.title = text,
        ),
        AuthorsSectionWidget(
          authors: book.authors,
        ),
        TextFormField(
          focusNode: descriptionFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).description),
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          initialValue: book.description != null ? book.description : "",
          validator: (text) => _validator(text),
          onSaved: (text) => book.description = text,
          onEditingComplete: (){
                FocusScope.of(context).requestFocus(publisherFocus);
          },
        ),
        TextFormField(
          focusNode: publisherFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).publisher),
          initialValue: book.publisher != null ? book.publisher : "",
          validator: (text) => _validator(text),
          onSaved: (text) => book.publisher = text,
          onFieldSubmitted: (v){
                FocusScope.of(context).requestFocus(pagesFocus);
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(Localization.of(context).releaseDate,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
              )),
        ),
        ListTile(
          leading: Icon(Icons.today, color: Colors.grey[500]),
          title: DateTimeItem(
            dateTime: book.releaseDate,
            onChanged: (dateTime) =>
                setState(() => book.releaseDate = dateTime),
          ),
        ),
        TextFormField(
          focusNode: pagesFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).pages),
          initialValue: book.pages != null ? book.pages.toString() : "",
          validator: (text) {
            if (int.tryParse(text).isNaN)
              return Localization.of(context).priceError;
            else
              return null;
          },
          keyboardType: TextInputType.number,
          onSaved: (text) => book.pages = int.tryParse(text),
          onFieldSubmitted: (v){
                FocusScope.of(context).requestFocus(editionFocus);
          },
        ),
        TextFormField(
          focusNode: editionFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).edition),
          initialValue: book.edition != null ? book.edition : "",
          validator: (text) => _validator(text),
          onSaved: (text) => book.edition = text,
          onFieldSubmitted: (v){
                FocusScope.of(context).requestFocus(priceFocus);
          },
        ),
        TextFormField(
          focusNode: priceFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).price),
          initialValue: book.price != null ? book.price : "",
          validator: (text) => _validator(text),
          onSaved: (text) => book.price = text,
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

 void _showDialogSaving(BuildContext context){
  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: LoadingSpinner(Localization.of(context).savingInformations),
          );
        },
      );
  }

  void _showDialogErrorImage(BuildContext context){
  showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              Localization.of(context).error.toUpperCase(),
              style: TextStyle(
                color: Color.fromRGBO(140, 0, 50, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(Localization.of(context).insertImage),
            actions: <Widget>[
              FlatButton(
                child: Text(
                Localization.of(context).close.toUpperCase(),
                  style: TextStyle(
                    color: Color.fromRGBO(140, 0, 50, 1),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }