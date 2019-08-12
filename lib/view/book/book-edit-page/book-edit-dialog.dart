import 'package:dima2018_colombo_troianiello/firebase-provider.dart';

import './image-form-widget.dart';
import '../../common/localization.dart';
import 'package:flutter/material.dart';
import '../../common/date-picker.dart';
import '../../../model/book.model.dart';
import './authors-section.dart';
import '../../common/loading-spinner.dart';
import 'dart:io';

///Allows to edit the informations of a given [Book].
///
///This widget is a [StatefulWidget].
class BookEditDialog extends StatefulWidget {
  ///The [Book] to edit.
  ///
  ///If [book] is null, this widget creates an empty [Book].
  final Book book;

  ///The identifier of the book to insert.
  final String isbn;

  ///Constructor of BookEditDialog.
  ///
  ///Receives [isbn] or [book], one of them must be not null.
  ///[isbn] is the identifier of the book to insert on Firestore.
  ///The [book] contains the informations to edit, if [book] is null, 
  ///this widget creates an empty [Book] associated to [isbn].
  BookEditDialog({
    this.isbn,
    this.book,
  }) : assert((isbn != null && book == null) || (isbn == null && book != null));

  //Creates the state of [BookEditDialog].
  @override
  _BookEditDialogState createState() => new _BookEditDialogState();
}

///The state of [BookEditDialog].
class _BookEditDialogState extends State<BookEditDialog> {
  ///The mode of [BookEditDialog].
  ///
  ///If [_addBook] is true, the [widget.book] is null and this state
  ///creates a new [Book] with [widget.isbn] to fill. After this [book]
  ///is saved in the collection Book, on Firestore.
  ///If [_addBook] is false, the [widget.book] is not null and this state
  ///handles the edit of it. After this [book] is saved in the collection Request,
  ///on Firestore.
  bool _addBook;

  ///The [Book] to edit.
  Book _book;

  ///The image of this [_book].
  File _image;

  ///The key of the form.
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  ///[FocusNode] of [TextFormField] of [_book.description].
  final FocusNode _descriptionFocus = FocusNode();


  ///[FocusNode] of [TextFormField] of [_book.publisher].
  final FocusNode _publisherFocus = FocusNode();

  ///[FocusNode] of [TextFormField] of [_book.price].
  final FocusNode _priceFocus = FocusNode();

  ///[FocusNode] of [TextFormField] of [_book.pages].
  final FocusNode _pagesFocus = FocusNode();

  ///[FocusNode] of [TextFormField] of [_book.edition].
  final FocusNode _editionFocus = FocusNode();

  //Initializes [_addBook] and [_book], if [widget.book] is null.
  @override
  void initState() {
    super.initState();
    _addBook = widget.book == null;
    if (_addBook) {
      this._book = Book();
      _book.isbn = widget.isbn;
    } else
      this._book = widget.book.clone();
  }

  //If [_addBook] is true, the title is "Add new book".
  //Otherwise, the title is "Suggest changes",
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: _addBook
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

  ///Saves [_book] on Firestote.
  ///
  ///If [_addBook] is true, [_book] is saved in the collection Book, on Firestore.
  ///If [_addBook] is false, [_book] is saved in the collection Request, on Firestore.
  ///If [_image] is null, an error dialog is shown.
  ///When saving on Firestore, a dialog, that is not dismissable, is shown.
  Future<void> _saveBook(BuildContext context) async {
    if (_book.image == null && _image == null) {
      _showDialogErrorImage(context);
      return;
    }
    _showSavingDialog(context);
    if (_image != null)
      _book.image =
          await FireProvider.of(context).book.uploadFile(_image, !_addBook);
    if (_addBook)
      await FireProvider.of(context).book.saveBook(_book);
    else
      FireProvider.of(context)
          .book
          .saveRequest(_book, FireProvider.of(context).auth.getUserId());
    //Pop of SavingDialog.
    Navigator.pop(context);
    //Pop of this widget.
    Navigator.pop(context, _book);
  }

  ///Builds the body of this widget.
  ///
  ///Returns a [Column], contaning several [TextFormField],
  ///the [AuthorsSectionWidget] and the [ImageFormSectionWidget].
  ///All [TextFormField] widgets have autofocus.
  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageFormSectionWidget(
                book: _book,
                saveImage: (File file) {
                  if (file != null) _image = file;
                }),
          ],
        ),
        TextFormField(
          autofocus: true,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(_descriptionFocus);

          },
          decoration:
              InputDecoration(labelText: Localization.of(context).title),
          initialValue: _book.title != null ? _book.title : "",
          validator: (text) => _validator(text),
          onSaved: (text) => _book.title = text,
        ),
        AuthorsSectionWidget(
          authors: _book.authors,
        ),
        TextFormField(
          focusNode: _descriptionFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).description),
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          initialValue: _book.description != null ? _book.description : "",
          validator: (text) => _validator(text),
          onSaved: (text) => _book.description = text,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_publisherFocus);

          },
        ),
        TextFormField(
          focusNode: _publisherFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).publisher),
          initialValue: _book.publisher != null ? _book.publisher : "",
          validator: (text) => _validator(text),
          onSaved: (text) => _book.publisher = text,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(_pagesFocus);
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
            dateTime: _book.releaseDate,
            onChanged: (dateTime) =>
                setState(() => _book.releaseDate = dateTime),
          ),
        ),
        TextFormField(
          focusNode: _pagesFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).pages),
          initialValue: _book.pages != null ? _book.pages.toString() : "",
          validator: (text) {
            if (int.tryParse(text).isNaN)
              return Localization.of(context).numberError;
            else
              return null;
          },
          keyboardType: TextInputType.number,
          onSaved: (text) => _book.pages = int.tryParse(text),
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(_editionFocus);
          },
        ),
        TextFormField(
          focusNode: _editionFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).edition),
          initialValue: _book.edition != null ? _book.edition : "",
          validator: (text) => _validator(text),
          onSaved: (text) => _book.edition = text,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(_priceFocus);
          },
        ),
        TextFormField(
          focusNode: _priceFocus,
          decoration:
              InputDecoration(labelText: Localization.of(context).price),
          initialValue: _book.price != null ? _book.price : "",
          validator: (text) => _validator(text),
          onSaved: (text) => _book.price = text,
        ),
      ],
    );
  }

  ///Validates the text of a [TextFormField].
  String _validator(String text) {
    if (text == "")
      return Localization.of(context).fieldError;
    else
      return null;
  }

  ///Shows a [AlertDialog], containig [LoadingSpinner], during the saving.
  void _showSavingDialog(BuildContext context) {
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

  ///Shows a [AlertDialog], containig an error message.
  void _showDialogErrorImage(BuildContext context) {
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

}
