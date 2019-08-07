import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";

/// Widget that display the libary image.
class ImageBackground extends StatelessWidget {
  ImageBackground({Key key, this.width, this.fileImage, this.urlImage})
      : super(key: key);
  final double width;
  final File fileImage;
  final String urlImage;

  /// Method to build the widget.
  ///
  /// It can show an image from: a file, network or assets.
  /// Files have precedence on network an network has precedence on assets.
  @override
  Widget build(BuildContext context) {
    if (fileImage != null)
      return Image.file(
        fileImage,
        height: width,
        fit: BoxFit.cover,
      );

    if (urlImage != null)
      return CachedNetworkImage(
        height: width,
        fit: BoxFit.cover,
        imageUrl: urlImage,
      );

    return Image.asset(
      "assets/images/library.jpeg",
      fit: BoxFit.cover,
    );
  }
}
