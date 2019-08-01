import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../model/library.model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../firebase/library-repo.dart';
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
      child = LoadingSpinner();
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
              child: _getImage(width),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IconTheme(
                data: IconThemeData(size: 24.0, color: Colors.white70),
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      if (_image != null || _library.image != null)
                        IconButton(
                          icon: Icon(Icons.delete),
                          iconSize: 24,
                          onPressed: () {
                            if (_image != null) {
                              _image = null;
                            } else if (_library.image != null) {
                              _library.image = null;
                            }
                            setState(() {});
                          },
                        ),
                      IconButton(
                        icon: Icon(Icons.file_upload),
                        iconSize: 24,
                        onPressed: () => _addPhoto(false),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        iconSize: 24,
                        onPressed: () => _addPhoto(true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: 'Library name'),
          ),
        ),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text("Favourite library"),
          onChanged: (val) {
            setState(() {
              _favourite = val;
            });
          },
          value: _favourite,
        ),
        ButtonTheme.bar(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("CANCEL"),
              ),
              FlatButton(
                onPressed:
                    _controller.text.length == 0 ? null : () => _handleSave(),
                child: Text("SAVE"),
              )
            ],
          ),
        ),
      ],
    );
  }

  _addPhoto(bool camera) async {
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

  Widget _getImage(double width) {
    if (_image != null) {
      return Image.file(
        _image,
        height: width,
        fit: BoxFit.cover,
      );
    } else if (_library.image != null) {
      return CachedNetworkImage(
        height: width,
        fit: BoxFit.cover,
        imageUrl: _library.image,
      );
    } else {
      return Image.asset(
        "assets/images/library.jpeg",
        fit: BoxFit.cover,
      );
    }
  }

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

  Future _saveLibrary(String imageUrl) async {
    Library lib = new Library();
    lib.reference = _library.reference;
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
