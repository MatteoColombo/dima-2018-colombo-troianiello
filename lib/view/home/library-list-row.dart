import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/library-page.dart';
import 'package:dima2018_colombo_troianiello/view/home/row-popup-menu.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import "package:flutter/material.dart";

class LibraryListRow extends StatelessWidget {
  LibraryListRow(
      {Key key, this.library, this.selecting, this.isSelected, this.onSelect})
      : super(key: key);
  final Library library;
  final bool isSelected;
  final bool selecting;
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
          onTap: !isSelected && !selecting
              ? () => _openLibrary(
                    context,
                  )
              : () => onSelect(library.id),
          onLongPress: isSelected ? null : () => onSelect(library.id),
          onTapCancel: () => null,
          child: Container(
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

  _changeFavouriteState(Library library) {
    libManager.updateFavouritePreference(library.id, !library.isFavourite);
  }

  _openLibrary(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LibraryPage(
          library: library,
        ),
      ),
    );
  }

  _getLibraryImage(BuildContext context) {
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

  _getNameWidget(BuildContext context) {
    return ListTile(
      title: Text(library.name),
      subtitle: Text('Contiene ${library.bookCount ?? 0} libri'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: isSelected ? null : () => _changeFavouriteState(library),
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
