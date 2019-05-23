import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../model/author.model.dart';

class AuthorsSectionWidget extends StatefulWidget {
  final List<Author> authors;

  AuthorsSectionWidget({@required this.authors});
  _AuthorsSectionWidgetState createState() => new _AuthorsSectionWidgetState();
}

class _AuthorsSectionWidgetState extends State<AuthorsSectionWidget> {
  Map<Author, Widget> mapForms;

  _AuthorsSectionWidgetState() {
    mapForms = Map<Author, Widget>();
  }

  @override
  void initState() {
    super.initState();
    _addForms();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "Authors",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () => setState(() {
                  Author newAuthor = Author();
                  newAuthor.name = 'Nome';
                  newAuthor.surname = 'Cognome';
                  widget.authors.add(newAuthor);
                  _addForms();
                }),
          ),
        ),
        ...mapForms.values,
      ],
    );
  }

  void _addForms() {
    for(Author author in widget.authors)
    mapForms.putIfAbsent(
      author,
      () => ListTile(
            key: Key(DateTime.now().toString()),
            leading: Icon(Icons.person),
            title: TextFormField(
              initialValue: author.toString(),
              validator: (String text) {
                RegExp regExp =
                    RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
                if (!text.contains(' ') || !regExp.hasMatch(text))
                  return 'Author must have a name and a surname';
                else
                  return null;
              },
              onSaved: (String text) {
                List<String> strings = text.split(' ');
                author.clear();
                author.name = strings.removeAt(0);
                author.surname = strings.removeLast();
                author.secondName = "";
                for (String string in strings)
                  author.secondName += " $string";
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => setState(() {
                    widget.authors.remove(author);
                    mapForms.remove(author);
                    print(widget.authors.toString());
                  }),
            ),
          ),
    );
  }
}
