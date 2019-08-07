import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/favourite-checkbox.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/image-background.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/image-buttons-enum.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/image-buttons.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/name-text-field.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/save-button-bar.dart';
import 'package:flutter/material.dart';
import '../../model/library.model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../firebase/library-repo.dart';
import '../common/loading-spinner.dart';

/// A dialog used to edit a library.
class EditLibrary extends StatefulWidget {
  EditLibrary({Key key, this.library}) : super(key: key);
  final Library library;

  _EditLibraryState createState() => _EditLibraryState(library);
}

class _EditLibraryState extends State<EditLibrary> {
  /// Whether the library is favourite or not.
  bool _favourite = false;

  /// The file used to store the image loaded from memory or from camera.
  File _image;

  /// The text controller used to manage the library name text field.
  TextEditingController _controller;

  /// True if saving operation is on going.
  bool _saving = false;

  /// The library that is being edited.
  Library _library;

  _EditLibraryState(this._library) {
    _controller = TextEditingController(text: _library.name);
    _favourite = _library.isFavourite;
  }

  /// Disposes the text controller.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Method used to build the widget.
  ///
  /// If it is saving, show a [LoadingSpinner] dialog.
  /// Otherwise show the edit page.
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_saving)
      child = LoadingSpinner(Localization.of(context).savingLibrary);
    else
      child = _getDialog();
    return Dialog(
      child: child,
    );
  }

  /// Returns the main widget of the class.
  ///
  /// It is the widget rendered in the normal state and allows to edit the library information.

  Widget _getDialog() {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: width,
              height: 250,
              child: ImageBackground(
                width: width,
                fileImage: _image,
                urlImage: _library.image,
              ),
            ),
            ImageButtons(
              hasImage: (_image != null || _library.image != null),
              callback: _handleImgButtons,
            ),
          ],
        ),
        NameTextField(
          controller: _controller,
        ),
        FavouriteCheckbox(
          favourite: _favourite,
          onChange: (val) {
            setState(() {
              _favourite = val;
            });
          },
        ),
        SaveButtonBar(
          canSave: _controller.text.length > 0,
          onSave: _handleSave,
        ),
      ],
    );
  }

  /// Handles the tap of the buttons over the image.
  ///
  /// It receives a [ImgBtnEnum] as a parameter which represents the choice.
  void _handleImgButtons(ImgBtnEnum choice) {
    switch (choice) {
      case ImgBtnEnum.Delete:
        _deletePhoto();
        break;
      case ImgBtnEnum.Upload:
        _addPhoto(false);
        break;
      case ImgBtnEnum.Photo:
        _addPhoto(true);
        break;
    }
  }

  /// Deletes the photo.
  ///
  /// If both a file and network image are set, the first eliminated is the one stored in the file
  void _deletePhoto() {
    if (_image != null)
      _image = null;
    else if (_library.image != null) _library.image = null;
    setState(() {});
  }

  /// Adds an image as library photo.
  ///
  /// It uses an image picker to pick an image either from gallery or from camera.
  Future<void> _addPhoto(bool camera) async {
    try {
      var image = await ImagePicker.pickImage(
          source: camera ? ImageSource.camera : ImageSource.gallery,
          maxHeight: 500,
          maxWidth: 500);
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  /// Saves the library.
  ///
  /// Set the state to saving so that the progress indicator is shown.
  /// If there is an image, it is uploaded to firestore.
  /// Then the method to save the library is called.
  Future _handleSave() async {
    setState(() {
      _saving = true;
    });
    if (_image != null) {
      String imageUrl = await libManager.uploadFile(_image);
      _saveLibrary(imageUrl);
    } else {
      _saveLibrary(null);
    }
  }

  /// Saves the library to the database.
  ///
  /// It receives a [String] parameter which represents the URL of the new image, if it has to be saved.
  Future _saveLibrary(String imageUrl) async {
    Library lib = new Library();
    lib.id = _library.id;
    lib.bookCount = _library.bookCount;
    lib.name = _controller.text;
    lib.isFavourite = _favourite;
    lib.image = imageUrl ?? _library.image;
    await libManager.saveLibrary(lib);
    setState(() {
      _saving = false;
    });

    Navigator.of(context).pop();
  }
}
