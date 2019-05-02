import 'package:flutter/material.dart';
import '../../model/library.model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../firebase/library-repo.dart';

class EditLibrary extends StatefulWidget {
  EditLibrary({this.library, this.isNew});
  final Library library;
  final bool isNew;

  @override
  _EditLibraryState createState() => _EditLibraryState(library, isNew);
}

class _EditLibraryState extends State<EditLibrary> {
  _EditLibraryState(this._library, this._isNew) {
    if (_isNew) {
      _library = Library(isFavourite: false, name: "");
    }

    _textController = TextEditingController(text: _library.name);
  }

  Library _library;
  bool _isNew;
  TextEditingController _textController;
  File _image;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget imgWidget;
    if (_library.image == null && _image == null)
      imgWidget = Image.asset(
        "images/library.jpeg",
        height: 110,
        width: 110,
        fit: BoxFit.fitHeight,
      );
    else if (_image != null) {
      imgWidget = Image.file(
        _image,
        height: 110,
        width: 110,
        fit: BoxFit.fitWidth,
      );
    } else {
      imgWidget = Image.network(
        _library.image,
        height: 110,
        width: 110,
        fit: BoxFit.fitWidth,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isNew ? "Nuova libreria" : "Modifica ${_library.name}",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _handleSave(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                imgWidget,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Modifica immagine",
                        style: TextStyle(fontSize: 24),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              iconSize: 36,
                              color: Theme.of(context).primaryColor,
                              onPressed: () => _getImageFromCamera(),
                              icon: Icon(
                                Icons.camera_alt,
                                semanticLabel: "Scatta una foto",
                              ),
                            ),
                            IconButton(
                              iconSize: 36,
                              color: Theme.of(context).primaryColor,
                              onPressed: () => _getImageFromGallery(),
                              icon: Icon(
                                Icons.file_upload,
                                semanticLabel: "Carica immagine",
                              ),
                            ),
                            IconButton(
                              iconSize: 36,
                              color: Theme.of(context).primaryColor,
                              onPressed: () => _deleteImage(),
                              icon: Icon(
                                Icons.delete,
                                semanticLabel: "Elimina",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  hintText: "per esempio: DC Comics",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: CheckboxListTile(
                value: _library.isFavourite,
                title: Text("Libreria preferita"),
                activeColor: Theme.of(context).primaryColor,
                onChanged: (bool check) {
                  setState(() {
                    _library.isFavourite = check;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _handleSave(BuildContext context) async {
    if (_image != null) {
      String imageUrl = await libManager.uploadFile(_image);
      _library.image = imageUrl;
      _saveLibrary(context);
    } else {
      _saveLibrary(context);
    }
  }

  Future _saveLibrary(BuildContext context) async {
    _library.name = _textController.text;
    await libManager.saveLibrary(_library);
    Navigator.of(context).pop();
  }

  Future _getImageFromCamera() async {
    _image = null;
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 200, maxHeight: 200);

    setState(() {
      _image = image;
    });
  }

  Future _getImageFromGallery() async {
    _image = null;
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 200, maxHeight: 200);

    setState(() {
      _image = image;
    });
  }

  _deleteImage() {
    setState(() {
      if (_image != null)
        _image = null;
      else if (_library.image != null) _library.image = null;
    });
  }
}
