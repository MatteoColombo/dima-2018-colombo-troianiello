import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({Key key, @required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(labelText: 'Library name'),
      ),
    );
  }
}