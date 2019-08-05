import 'package:dima2018_colombo_troianiello/view/common/appbar-buttons-enum.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LibraryPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  LibraryPageAppbar(
      {Key key, this.title, this.selecting, this.selectedCount, this.callback})
      : super(key: key);
  final String title;
  final bool selecting;
  final int selectedCount;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    if (selecting)
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => callback(AppBarBtn.Clear, context),
        ),
        title: Text("$selectedCount"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.select_all),
            onPressed: () => callback(AppBarBtn.SelectAll, context),
          ),
          IconButton(
            icon: Icon(MdiIcons.arrowRightBold),
            onPressed: () => callback(AppBarBtn.Move, context),
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () => callback(AppBarBtn.DeleteAll, context),
          )
        ],
      );
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.sort),
          onPressed: () => callback(AppBarBtn.Sort, context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
