import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/view/home/library-list-row.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:flutter/material.dart';

class LibraryList extends StatelessWidget {
  LibraryList(
      {@required this.onSelect,
      @required this.selected,
      @required this.libraries});

  final List<String> selected;
  final Function onSelect;
  final List<Library> libraries;

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

  _showLoader(BuildContext context) {
    return Center(
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
        child: CircularProgressIndicator(),
      ),
    );
  }

  _showList(BuildContext context, List<Library> libs) {
    return ListView.builder(
      itemCount: libs.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return LibraryListRow(
          key: Key(libs[index].id),
          library: libs[index],
          isSelected: selected.contains(libs[index].id),
          selecting: selected.length > 0,
          onSelect: onSelect,
        );
      },
    );
  }

  _showNoLibsImg(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/stack.png",
        width: 150,
      ),
    );
  }
}
