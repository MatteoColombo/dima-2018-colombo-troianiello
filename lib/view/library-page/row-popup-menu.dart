import 'package:dima2018_colombo_troianiello/view/library-page/popup-option-enum.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RowPopUpMenu extends StatelessWidget {
  RowPopUpMenu(
      {Key key,
      @required this.callback,
      @required this.enabled})
      : super(key: key);
  final Function callback;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enabled: enabled,
      onSelected: (val) => callback(val, context),
      itemBuilder: (context) {
        return _getItems();
      },
    );
  }

  _getItems() {
    return [
      PopupMenuItem(
        value: PopUpOpt.Move,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(MdiIcons.arrowRightBold),
            ),
            Text("Change Library")
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
            Text("Delete Book")
          ],
        ),
      )
    ];
  }
}
