import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/confirm-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/edit-library.dart';
import 'package:flutter/material.dart';

/// Displays a PopupMenu used in [LibraryListRow] items
///
/// It can be disabled if the [LibraryListRow] is selected, so that it doesn't catch gestures.
class RowPopupMenu extends StatelessWidget {
  RowPopupMenu({Key key, this.library, this.enabled}) : super(key: key);

  /// The library to which the popup is related to.
  final Library library;

  ///True if the menu is enabled
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enabled: enabled,
      onSelected: (val) => _handleCardMenu(val, context),
      itemBuilder: (context) {
        return _getMenuItems(context);
      },
    );
  }

  /// Handles the menu option taps.
  ///
  /// - [val] is an int that represents the choice.
  /// - [BuildContext] is need to show a Dialog as this is a Stateless widget.
  ///
  /// In case of Edit it shows a [EditLibrary] dialog.
  /// In case of Delete, it shows a [ConfirmDialog] and in case of positive answer it deletes the library.
  void _handleCardMenu(int val, BuildContext context) async {
    if (val == 0) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => EditLibrary(
          library: library,
        ),
      );
    } else if (val == 1) {
      bool confirm = await showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
          question: Localization.of(context).areYouSure,
        ),
      );
      if (confirm ?? false) {
        LibProvider.of(context).library.deleteLibrary(library);
      }
    }
  }

  /// Returns a list of options that is used to build the PopUp menu.
  List<PopupMenuItem> _getMenuItems(BuildContext context) {
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
