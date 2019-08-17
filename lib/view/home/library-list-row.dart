import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/library-page.dart';
import 'package:dima2018_colombo_troianiello/view/home/row-popup-menu.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import "package:flutter/material.dart";

/// An element of the library list.
///
/// It shows the [Library] information and allows gestures.
/// A long press selects/unselect the library.
/// A tap opens the [LibraryPage], while a tap in selecting mode selects/unselects the library.
class LibraryListRow extends StatelessWidget {
  LibraryListRow(
      {Key key, this.library, this.selecting, this.isSelected, this.onSelect})
      : super(key: key);

  /// The library that is displayed.
  final Library library;

  /// True if this library is selected.
  final bool isSelected;

  /// True if selection mode is active.
  final bool selecting;

  /// Callback to be called when this library is selected/unselected.
  ///
  /// It accepts as [String] containing the current library id.
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 8,
        type: MaterialType.canvas,
        borderRadius: BorderRadius.circular(5),
        animationDuration: Duration(milliseconds: 100),
        child: InkWell(
          splashColor: Colors.black12,
          highlightColor: Colors.transparent,
          // If the library isn't selected and selecting mode is not active, open it.
          onTap: !isSelected && !selecting
              ? () => _openLibrary(
                    context,
                  )
              // If selecting mode is active,selects/unselects the library.
              : () => onSelect(library.id),
          // If not selecting, selects the library. If selecting do nothing.
          onLongPress: isSelected ? null : () => onSelect(library.id),
          onTapCancel: () => null,
          child: Container(
            // When the library is selected change its background color.
            color: isSelected ? Colors.lightBlue[50] : null,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _getLibraryImage(context),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _getNameWidget(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Callback method called when the "is Favourite" [IconButton] is tapped.
  ///
  /// It is used to update the library "is Favourite" state of the library.
  void _changeFavouriteState(BuildContext context) {
    LibProvider.of(context)
        .library
        .updateUserFavouritePreference(library.id, !library.isFavourite);
  }

  /// Opens the library in a new page.
  void _openLibrary(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LibraryPage(
          library: library,
          context: context,
        ),
      ),
    );
  }

  /// Used to build the library image section.
  ///
  /// Returns a [Widget] containinig an image.
  /// If the librars has an image, it is loaded with a [CachecImageNetwork], otherwise a default imaage is shown.
  Widget _getLibraryImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Hero(
          child: library.image != null
              ? CachedNetworkImage(
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  imageUrl: library.image,
                  placeholder: (context, _) => Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator()),
                  ),
                )
              : Image.asset(
                  "assets/images/library.jpeg",
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
          tag: library.id,
        ),
      ),
    );
  }

  /// Returns a [Widget] containing information about the library and action buttons.
  ///
  /// Returns a [ListTile] that displays library title and book count.
  /// The [ListTile] Contains two action button as well:
  /// - an [IconButton] to change the favourite state of the library.
  /// - A [RowPopupMenu] to delete ot edit the library.
  Widget _getNameWidget(BuildContext context) {
    return ListTile(
      title: Text(library.name),
      subtitle: Text(Localization.of(context).bookCount(library.bookCount)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: isSelected ? null : () => _changeFavouriteState(context),
            iconSize: 32,
            icon: Icon(
              library.isFavourite ? Icons.star : Icons.star_border,
            ),
          ),
          RowPopupMenu(enabled: !isSelected, library: library),
        ],
      ),
    );
  }
}
