import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  ConfirmDialog({this.question});
  final String question;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(question),
      actions: <Widget>[
        ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text((Localization.of(context).cancel).toUpperCase()),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text((Localization.of(context).confirm).toUpperCase()),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        )
      ],
    );
  }
}
