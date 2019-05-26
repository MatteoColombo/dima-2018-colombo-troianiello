import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/book.model.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ImageFormSectionWidget extends StatefulWidget {
  final Book book;
  ImageFormSectionWidget({@required this.book});
  _ImageFormSectionWidgetState createState() =>
      new _ImageFormSectionWidgetState(book);

  saveImage(){}
}

class _ImageFormSectionWidgetState extends State<ImageFormSectionWidget> {
  Book _book;
  File _image;

  _ImageFormSectionWidgetState(Book book) {
    this._book = book;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildImageSection(context),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    double _width = data.size.width * 2 / 5;
    double _height = _width * (4 / 3);
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      width: _width,
      height: _height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _getImgWidget(context),
          Container(
            alignment: Alignment.center,
            color: Colors.white30,
            child: IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _buildPopupDialog(context),
            ),
          ),
        ],
      ),
    );
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

  void _buildPopupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a picture'),
                onTap: () => setState(() {
                      _getImage(true);
                      Navigator.of(context).pop();
                    }),
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Take from the gallery'),
                onTap: () => setState(() {
                      _getImage(false);
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  void _getImage(bool camera) async {
    try {
      var image = await ImagePicker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      setState(() {
        _image = image;
      });
    } catch (e) {
      print(e);
    }
  }
}
