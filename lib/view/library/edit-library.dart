import 'package:flutter/material.dart';
import '../../model/library.model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../firebase/library-repo.dart';
import '../common/loading-spinner.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    _saving = false;
  }

  Library _library;
  bool _isNew;
  TextEditingController _textController;
  File _image;
  bool _saving;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> scaffoldBody = [_buildBody(context)];
    if (_saving) scaffoldBody.add(LoadingSpinner());

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(children: scaffoldBody),
      ),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _getImgWidget(context),
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
                          onPressed: () => _getImage(true),
                          icon: Icon(
                            Icons.camera_alt,
                            semanticLabel: "Scatta una foto",
                          ),
                        ),
                        IconButton(
                          iconSize: 36,
                          color: Theme.of(context).primaryColor,
                          onPressed: () => _getImage(false),
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
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        _isNew ? "Nuova libreria" : "Modifica ${_library.name}",
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () => _handleSave(context),
        )
      ],
    );
  }

  Widget _getImgWidget(BuildContext context) {
    if (_library.image == null && _image == null)
      return Image.asset(
        "images/library.jpeg",
        height: 110,
        width: 110,
        fit: BoxFit.fitHeight,
      );
    else if (_image != null)
      return Image.file(
        _image,
        height: 110,
        width: 110,
        fit: BoxFit.fitWidth,
      );
    return CachedNetworkImage(
      width: 110,
      height: 110,
      fit: BoxFit.fitWidth,
      imageUrl: _library.image,
      placeholder: (context, url) => Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
          child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Image.asset("images/library.png",
          width: 110, height: 110, fit: BoxFit.fitHeight),
    );
  }

  Future _handleSave(BuildContext context) async {
    setState(() {
      _saving = true;
    });
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
    setState(() {
      _saving = false;
    });
    Navigator.of(context).pop();
  }

  _getImage(bool camera) async {
    try {
      var image = await ImagePicker.pickImage(
          source: camera ? ImageSource.camera : ImageSource.gallery,
          maxWidth: 200,
          maxHeight: 200);

      setState(() {
        _image = image;
      });
    } catch (e) {
      print(e);
    }
  }

  _deleteImage() {
    setState(() {
      if (_image != null)
        _image = null;
      else if (_library.image != null) _library.image = null;
    });
  }
}
