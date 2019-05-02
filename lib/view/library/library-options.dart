import 'package:flutter/material.dart';
import './list-options-enum.dart';

class OptionsDialog {
  Future<LibraryOption> showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Elimina libreria"),
              ),
              onPressed: () => Navigator.of(context).pop(LibraryOption.Delete),
            ),
            SimpleDialogOption(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Modifica libreria"),
              ),
              onPressed: () => Navigator.of(context).pop(LibraryOption.Edit),
            ),
          ],
        );
      },
    );
  }
}
