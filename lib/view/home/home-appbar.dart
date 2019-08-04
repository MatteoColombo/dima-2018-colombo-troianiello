import 'package:dima2018_colombo_troianiello/view/common/appbar-buttons-enum.dart';
import "package:flutter/material.dart";

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppbar({Key key, this.selecting, this.callback, this.selectedCount})
      : super(key: key);

  final bool selecting;
  final Function callback;
  final int selectedCount;

  @override
  Widget build(BuildContext context) {
    if (selecting)
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => callback(AppBarBtn.Clear),
        ),
        title: Text("$selectedCount"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () => callback(AppBarBtn.DeleteAll),
          )
        ],
      );
    return AppBar(
      title: Text("NonSoloLibri"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: null,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
