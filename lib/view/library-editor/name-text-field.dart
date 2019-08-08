import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';

/// Shows a textfield used to edit the library name.
class NameTextField extends StatelessWidget {
  NameTextField({Key key, @required this.controller}) : super(key: key);

  /// The text editor controller.
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        decoration:
            InputDecoration(labelText: Localization.of(context).libraryName),
      ),
    );
  }
}
