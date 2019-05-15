import 'package:flutter/material.dart';

class AuthorsSectionWidget extends StatefulWidget {
  final List<String> authors;

  AuthorsSectionWidget({@required this.authors});
  _AuthorsSectionWidgetState createState() => new _AuthorsSectionWidgetState();
}

class _AuthorsSectionWidgetState extends State<AuthorsSectionWidget> {
 
   @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Authors: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () => null,
            ),
            Column(children: _buildAuthorsForms(),)
          ],
        ),
      ],
    );
  }

  List<Widget> _buildAuthorsForms(){
    List<Widget> _forms= new List<Widget>();
    for(String author in widget.authors){
      _forms.add(
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: author,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => setState(() {
                widget.authors.remove(author);
              }),
            ),
          ],
        ),
      );
      return _forms;
    }
  }
}