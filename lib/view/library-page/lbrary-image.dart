import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Displays the library image in the library page.
class LibraryImage extends StatelessWidget {
  LibraryImage({Key key, this.image, this.width, this.tag}) : super(key: key);

  /// The image to be displayed. If null the default image is shown.
  final String image;

  /// The width of the list. The image adapts to that width.
  final double width;

  /// A tag used to show the hero animation when opening the library page.
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Material(
        elevation: 7,
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
      ),
    );
  }
}
