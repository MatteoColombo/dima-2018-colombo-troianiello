import 'package:dima2018_colombo_troianiello/camera/image-picker.dart';
import 'package:dima2018_colombo_troianiello/firebase-provider.dart';
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
import '../common/loading-spinner.dart';

class EditLibrary extends StatefulWidget {
  EditLibrary({Key key, this.library}) : super(key: key);
  final Library library;

  _EditLibraryState createState() => _EditLibraryState(library);
}

class _EditLibraryState extends State<EditLibrary> {
  bool _favourite = false;
  File _image;
  TextEditingController _controller;
  bool _saving = false;
  Library _library;

  _EditLibraryState(this._library) {
    _controller = TextEditingController(text: _library.name);
    _favourite = _library.isFavourite;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  _getDialog() {
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
          textController: _controller,
          onSave: _handleSave,
        ),
      ],
    );
  }

  _handleImgButtons(ImgBtnEnum choice) {
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

  _deletePhoto() {
    if (_image != null)
      _image = null;
    else if (_library.image != null) _library.image = null;
    setState(() {});
  }

  _addPhoto(bool camera) async {
    try {
      var image = await FireProvider.of(context).picker.getImage(
          500, 500, camera ? ImageSource.camera : ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _handleSave(BuildContext context) async {
    setState(() {
      _saving = true;
    });
    if (_image != null) {
      String imageUrl = await FireProvider.of(context).library.uploadFile(
            _image,
            FireProvider.of(context).auth.getUserId(),
          );
      _saveLibrary(imageUrl);
    } else {
      _saveLibrary(null);
    }
  }

  Future _saveLibrary(String imageUrl) async {
    Library lib = new Library();
    lib.id = _library.id;
    lib.bookCount = _library.bookCount;
    lib.name = _controller.text;
    lib.isFavourite = _favourite;
    lib.image = imageUrl ?? _library.image;
    await FireProvider.of(context).library.saveLibrary(
          lib,
          FireProvider.of(context).auth.getUserId(),
        );
    setState(() {
      _saving = false;
    });

    Navigator.of(context).pop();
  }
}
