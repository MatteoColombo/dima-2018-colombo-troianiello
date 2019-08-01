import 'package:flutter/material.dart';

class ConfirmDialog {
  Future<bool> instance(BuildContext context, String question) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(question),
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text("ANNULLA"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text("SÌ"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              )
            ],
          );
        });
  }
}
