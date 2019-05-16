import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../model/author.model.dart';

class AuthorsSectionWidget extends StatefulWidget {
  final List<Author> authors;

  AuthorsSectionWidget({@required this.authors});
  _AuthorsSectionWidgetState createState() => new _AuthorsSectionWidgetState();
}

class _AuthorsSectionWidgetState extends State<AuthorsSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0 * widget.authors.length,
      child: _buildListView(),
    );
  }

  Widget _buildListView(){
return ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            "Authors: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () => null,
          ),
        ),
        ..._buildAuthorsForms(),
      ],
    );
  }

  List<Widget> _buildAuthorsForms() {
    List<Widget> forms = new List<Widget>();
    for (Author author in widget.authors) {
      forms.add(
        ListTile(
          leading: Icon(Icons.person),
          title: TextFormField(
            decoration: InputDecoration(
              hintText: author.toString(),
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => setState(() {
                  widget.authors.remove(author);
                }),
          ),
        ),
      );
    }
    return forms;
  }
}
