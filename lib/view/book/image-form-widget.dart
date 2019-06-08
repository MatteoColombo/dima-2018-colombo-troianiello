import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/book.model.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ImageFormSectionWidget extends StatefulWidget {
  final Book book;
  final Function saveImage;
  ImageFormSectionWidget({@required this.book,@required this.saveImage});
  _ImageFormSectionWidgetState createState() =>
      new _ImageFormSectionWidgetState(book);
}

class _ImageFormSectionWidgetState extends State<ImageFormSectionWidget> {
  Book _book;
  File _image;

  _ImageFormSectionWidgetState(Book book) {
    this._book = book;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ..._buildImageSection(context),
      ],
    );
  }

  List<Widget> _buildImageSection(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    double _width = data.size.width * 2 / 5;
    double _height = _width * (4 / 3);
    List<Widget> children = [
      Container(
        padding: EdgeInsets.only(top: 8.0),
        width: _width,
        height: _height,
        child: _getImgWidget(context),
      ),
      Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () => setState(() {
                  _getImage(true);
                }),
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () => setState(() {
                  _getImage(false);
                }),
          ),
        ],
      ),
    ];
    return children;
  }

  Widget _getImgWidget(BuildContext context) {
    if (_image == null)
      return CachedNetworkImage(
        imageUrl: _book.image,
        placeholder: (context, url) => SizedBox(
              width: 50,
              height: 50,
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
                child: CircularProgressIndicator(),
              ),
            ),
        errorWidget: (context, url, error) => Image.asset(
              "images/book.jpg",
            ),
      );
    else
      return Image.file(
        _image,
      );
  }
  
  void _getImage(bool camera) async {
    try {
      var image = await ImagePicker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 1280,
        maxWidth: 720,
      );
      setState(() {
        _image = image;
      });
      widget.saveImage(_image);
    } catch (e) {
      print(e);
    }
  }
}
