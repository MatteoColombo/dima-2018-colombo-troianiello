import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";

class ImageBackground extends StatelessWidget {
  const ImageBackground({Key key, this.width, this.fileImage, this.urlImage})
      : super(key: key);
  final double width;
  final File fileImage;
  final String urlImage;

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
