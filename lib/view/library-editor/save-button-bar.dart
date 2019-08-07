import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';

/// Shows a bar with a save and cancel button.
///
/// It is used in the New and Edit Library widgets.
class SaveButtonBar extends StatelessWidget {
  SaveButtonBar({Key key, this.canSave, this.onSave}) : super(key: key);

  /// The callback method called when the saving button is tapped.
  final Function onSave;

  /// If true the save button is enabled.
  final bool canSave;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme.bar(
      child: ButtonBar(
        children: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(Localization.of(context).cancel.toUpperCase()),
          ),
          FlatButton(
            onPressed: canSave ? () => onSave() : null,
            child: Text(Localization.of(context).save.toUpperCase()),
          )
        ],
      ),
    );
  }
}
