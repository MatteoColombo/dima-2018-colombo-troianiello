import 'package:dima2018_colombo_troianiello/view/common/appbar-buttons-enum.dart';
import "package:flutter/material.dart";

/// The AppBar of the main page.
///
/// It supports three modes: normal, search and select.
/// Depending on the mode, different [IconButton] are shown.
class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppbar(
      {Key key,
      this.selecting = false,
      this.callback,
      this.selectedCount,
      this.searchController,
      this.searching = false})
      : assert(!(selecting && searching)),
        assert(!selecting || (selecting && selectedCount > 0)),
        assert(!searching || (searching && searchController != null)),
        super(key: key);

  /// True if the AppBar is in selection mode.
  final bool selecting;
  final Function callback;
  final int selectedCount;
  final bool searching;
  final TextEditingController searchController;

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
            icon: Icon(Icons.delete_sweep),
            onPressed: () => callback(AppBarBtn.DeleteAll, context),
          )
        ],
      );

    if (searching)
      return AppBar(
        title: TextField(
          controller: searchController,
          autofocus: true,
          style: new TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search, color: Colors.white),
            hintText: "Search...",
            hintStyle: new TextStyle(
              color: Colors.white,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => callback(AppBarBtn.Clear, context),
          ),
        ],
      );

    return AppBar(
      title: Text("NonSoloLibri"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => callback(AppBarBtn.Search, context),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
