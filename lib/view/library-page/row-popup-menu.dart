import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/popup-option-enum.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// A widget used to display an option in book-list PopUp menu.
class RowPopUpMenu extends StatelessWidget {
  RowPopUpMenu({Key key, @required this.callback, @required this.enabled})
      : super(key: key);

  /// The callback function called when an option is pressed.
  ///
  /// It takes two parameters.
  /// - val, [PopUpOpt] represents the choice of the user.
  /// - context [BuildContext] is needed as the widget at the upper level may need to display a dialog and a context is required.
  final Function callback;

  /// True if the PopUp menu is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enabled: enabled,
      onSelected: (val) => callback(val, context),
      itemBuilder: (context) {
        return _getItems(context);
      },
    );
  }

  /// Returns the list of PopUp menu items.
  List<PopupMenuEntry> _getItems(BuildContext context) {
    return [
      PopupMenuItem(
        value: PopUpOpt.Move,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(MdiIcons.arrowRightBold),
            ),
            Text(Localization.of(context).changeLibrary)
          ],
        ),
      ),
      PopupMenuItem(
        value: PopUpOpt.Delete,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.delete),
            ),
            Text(Localization.of(context).deleteBook)
          ],
        ),
      )
    ];
  }
}
