import 'package:flutter/material.dart';

class SaveButtonBar extends StatelessWidget {
  SaveButtonBar({Key key, this.textController, this.onSave})
      : super(key: key);
  final Function onSave;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme.bar(
      child: ButtonBar(
        children: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("CANCEL"),
          ),
          FlatButton(
            onPressed: textController.text.length == 0 ? null : () => onSave(),
            child: Text("SAVE"),
          )
        ],
      ),
    );
  }
}
