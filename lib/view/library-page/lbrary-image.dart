import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LibraryImage extends StatelessWidget {
  const LibraryImage({Key key, this.image, this.width, this.tag})
      : super(key: key);

  final String image;
  final double width;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Hero(
        child: image != null
            ? CachedNetworkImage(
                height: 200,
                width: width,
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                imageUrl: image,
              )
            : Image.asset(
                "assets/images/library.jpeg",
                height: 200,
                width: width,
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
              ),
        tag: tag,
      ),
    );
  }
}
