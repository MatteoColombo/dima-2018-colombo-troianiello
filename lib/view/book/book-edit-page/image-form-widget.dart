import 'package:cached_network_image/cached_network_image.dart';
import '../../common/localization.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/book.model.dart';
import 'package:flutter/material.dart';
import 'dart:io';

///Creates an input form to halde the new cover of the [Book].
///
///This widget is a [StatefulWidget].
class ImageFormSectionWidget extends StatefulWidget {
  ///The [Book] associated to the cover.
  final Book book;

  ///[Function], that allows to retrive the image saved with the form.
  final Function saveImage;

  ///Constructor of ImageFormSectionWidget.
  ///
  ///Receives a [Book] and a [Function], all required variabiles.
  ///[book] is the book associated to the cover and
  ///[saveImage] allows to retrive the image saved with the form.
  ImageFormSectionWidget({@required this.book, @required this.saveImage})
      : assert(book != null && saveImage != null);

  //Creates the state of this widget.
  _ImageFormSectionWidgetState createState() =>
      new _ImageFormSectionWidgetState(book);
}

///The state of [ImageFormSectionWidgdet].
class _ImageFormSectionWidgetState extends State<ImageFormSectionWidget> {
  ///The [Book] of the widget.
  Book _book;

  ///The inserted image using the form.
  File _image;

  ///Constructor of ImageFormSectionWidgetState.
  ///
  ///Receives the [Book] of the widget.
  _ImageFormSectionWidgetState(Book book) {
    this._book = book;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    double _width = data.size.width * 2 / 5;
    double _height = _width * (4 / 3);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 8.0),
          width: _width,
          height: _height,
          child: _getImgWidget(context),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.camera_alt,
                semanticLabel: Localization.of(context).labelTakePhoto,
              ),
              onPressed: () => setState(() {
                _getImage(true);
              }),
            ),
            IconButton(
              icon: Icon(
                Icons.image,
                semanticLabel: Localization.of(context).labelLoadImg,
              ),
              onPressed: () => setState(() {
                _getImage(false);
              }),
            ),
          ],
        ),
      ],
    );
  }

  ///Creates a widget that displays an [Image] or a [CachedNetworkImage].
  ///
  ///Displays a saved image through a file or a image on internet using a URL,
  ///if the image is not available, this widget displays a defaul image.
  Widget _getImgWidget(BuildContext context) {
    if (_book.image == null && _image == null)
      return Image.asset(
        "assets/images/book.jpg",
      );
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
          "assets/images/book.jpg",
        ),
      );
    else
      return Image.file(
        _image,
      );
  }

  ///Returns the image picked with the camera or from the gallery.
  ///
  ///If [camera] is true, the camera is open and is ready to take a picture.
  ///Otherwise, if [camera] is false, the gallery is opened.
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
