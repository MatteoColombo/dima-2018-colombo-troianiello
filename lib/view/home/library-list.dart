import 'package:dima2018_colombo_troianiello/view/home/library-list-row.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:flutter/material.dart';

/// Displays the list of libraries.
///
/// A widget that takes a list of [Library] and displays them.
/// It supports selection.
class LibraryList extends StatelessWidget {
  LibraryList(
      {@required this.onSelect,
      @required this.selected,
      @required this.libraries})
      : assert(selected != null),
        assert(selected.length == 0 || onSelect != null);

  /// A list of IDs that represent selected libraries.
  final List<String> selected;

  /// The callback method to be called when one of the libraries triggers the selection state change.
  final Function onSelect;

  /// The list of libraries.
  final List<Library> libraries;

  /// The method used to build the list.
  ///
  /// If the list of libraries is null, it means that it's still loading and a loading widget is shown.
  /// If the list has length zero, there is no library and an image is shown.
  /// If the list has lenght greater than zero, a list of [LibraryListRow] items is shown.
  @override
  Widget build(BuildContext context) {
    if (libraries == null) {
      return _showLoader(context);
    } else {
      if (libraries.length == 0) {
        return _showNoLibsImg(context);
      } else {
        return _showList(context, libraries);
      }
    }
  }

  /// Return a [Widget] containing a [CircularProgressIndicator].
  Widget _showLoader(BuildContext context) {
    return Center(
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Builds the list of [LibraryListRow] items.
  Widget _showList(BuildContext context, List<Library> libs) {
    return ListView.builder(
      itemCount: libs.length + 1,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        // Dummy element to avoid overlaps with the floating action button
        if (index == libs.length)
          return Container(
            height: 80,
          );
        return LibraryListRow(
          // We need to pass the ID so that we improve efficiency when rebuilding the list.
          key: Key(libs[index].id),
          library: libs[index],
          isSelected: selected.contains(libs[index].id),
          selecting: selected.length > 0,
          onSelect: onSelect,
        );
      },
    );
  }

  /// Returns an image.
  Widget _showNoLibsImg(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/stack.png",
        width: 150,
      ),
    );
  }
}
