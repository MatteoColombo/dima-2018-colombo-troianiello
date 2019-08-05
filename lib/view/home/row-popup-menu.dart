import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/confirm-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/edit-library.dart';
import 'package:flutter/material.dart';

class RowPopupMenu extends StatelessWidget {
  RowPopupMenu({Key key, this.library, this.enabled}) : super(key: key);
  final Library library;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enabled: enabled,
      onSelected: (val) => _handleCardMenu(val, library, context),
      itemBuilder: (context) {
        return _getMenuItems(context);
      },
    );
  }

  _handleCardMenu(int val, Library lib, BuildContext context) async {
    print(lib);
    if (val == 0) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => EditLibrary(
          library: lib,
        ),
      );
    } else if (val == 1) {
      bool confirm = await ConfirmDialog()
          .instance(context, Localization.of(context).areYouSure);
      if (confirm ?? false) {
        libManager.deleteLibrary(lib);
      }
    }
  }

  _getMenuItems(BuildContext context) {
    return [
      PopupMenuItem(
        value: 0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.edit),
            ),
            Text(Localization.of(context).editLibrary)
          ],
        ),
      ),
      PopupMenuItem(
        value: 1,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.delete),
            ),
            Text(Localization.of(context).deleteLibrary)
          ],
        ),
      )
    ];
  }
}
