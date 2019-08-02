import 'package:flutter/material.dart';
import '../../model/library.model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../firebase/library-repo.dart';
import '../common/loading-spinner.dart';

class NewLibrary extends StatefulWidget {
  NewLibrary({Key key}) : super(key: key);

  _NewLibraryState createState() => _NewLibraryState();
}

class _NewLibraryState extends State<NewLibrary> {
  bool _favourite = false;
  File _image;
  TextEditingController _controller;
  bool _saving = false;

  _NewLibraryState() {
    _controller = TextEditingController(text: "");
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
      child = LoadingSpinner("Saving library");
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
                      if (_image != null)
                        IconButton(
                          icon: Icon(Icons.delete),
                          iconSize: 24,
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
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
                child: Text("CREATE"),
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

  Image _getImage(double width) {
    if (_image == null)
      return Image.asset(
        "assets/images/library.jpeg",
        fit: BoxFit.cover,
      );
    return Image.file(
      _image,
      height: width,
      fit: BoxFit.cover,
    );
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
    Library lib = new Library(
      image: imageUrl ?? null,
      name: _controller.text,
      isFavourite: _favourite,
    );
    await libManager.saveLibrary(lib);
    setState(() {
      _saving = false;
    });
    Navigator.of(context).pop();
  }
}
