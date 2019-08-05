import 'package:flutter/material.dart';

class AddBookFloat extends StatelessWidget {
  const AddBookFloat({Key key, @required this.onPress}) : super(key: key);
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onPress(),
      child: Icon(Icons.add),
    );
  }
}
