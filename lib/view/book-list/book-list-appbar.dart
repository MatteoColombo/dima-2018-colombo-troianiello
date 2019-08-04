import 'package:flutter/material.dart';

class BookListAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BookListAppbar({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => null,
        ),
        IconButton(
          icon: Icon(Icons.sort),
          onPressed: () => null,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
