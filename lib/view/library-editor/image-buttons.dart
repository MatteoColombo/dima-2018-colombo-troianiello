import 'package:dima2018_colombo_troianiello/view/library-editor/image-buttons-enum.dart';
import 'package:flutter/material.dart';

/// A set of button displayed in overlay to the library image.
///
/// They are used to upload or delete the picture.
class ImageButtons extends StatelessWidget {
  ImageButtons({Key key, @required this.hasImage, @required this.callback})
      : super(key: key);

  /// True if the library has an image different to default one.
  final bool hasImage;

  /// The callback function called when a button is pressed.
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              // Disabled if there is no image.
              if (hasImage)
                IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 24,
                  onPressed: () => callback(ImgBtnEnum.Delete),
                ),
              IconButton(
                icon: Icon(Icons.file_upload),
                iconSize: 24,
                onPressed: () => callback(ImgBtnEnum.Upload),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt),
                iconSize: 24,
                onPressed: () => callback(ImgBtnEnum.Photo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
