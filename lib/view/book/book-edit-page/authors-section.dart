import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../model/author.model.dart';
import '../../common/localization.dart';

///This widget creates a form, that allows to edit the authors of the book.
///
///This widget extendes [StatefulWidget]. 
class AuthorsSectionWidget extends StatefulWidget {
  ///The list of all creators of this [Book].
  final List<Author> authors;

  ///Constructor of AuthorsSectionWidget.
  ///
  ///Receives the [List] of all authors of this [Book] 
  ///and it is required.
  AuthorsSectionWidget({@required this.authors});

  //Creates the state of this widget.
  _AuthorsSectionWidgetState createState() => new _AuthorsSectionWidgetState();
}

///The state of [AuthorsSectionWidget].
class _AuthorsSectionWidgetState extends State<AuthorsSectionWidget> {

  ///Associates each [Author] to a specific [TextFormField].
  Map<Author, Widget> _mapForms;
  
  ///Constructor of _AuthorsSectionWidgetState
  _AuthorsSectionWidgetState() {
    _mapForms = Map<Author, Widget>();
  }

  //Initializes this [mapForms]
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
          contentPadding: EdgeInsets.only(
            top: 10.0,
            right: 16,
          ),
          title: Text(
            Localization.of(context).authors,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black54,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () => setState(() {
              //Creates a new author.
              Author newAuthor = Author();
              //Initializes [newAuthor] with default values.
              newAuthor.name = Localization.of(context).name;
              newAuthor.surname = Localization.of(context).surname;
              widget.authors.add(newAuthor);
              //Creates the [TextFormField] associated to [newAuthor].
              _addForms();
            }),
          ),
        ),
        ..._mapForms.values,
      ],
    );
  }

  ///Populates [mapForms].
  ///
  ///If a author is new and is absent in [mapForms], adds the [TextFormField] associated.
  void _addForms() {
    for (Author author in widget.authors)
      _mapForms.putIfAbsent(
        author,
        () => ListTile(
          key: Key(DateTime.now().toString()),
          leading: Icon(Icons.person),
          title: TextFormField(
            //If [author] is empty, shows the [hintText], otherwise shows the [initialValue].
            decoration: InputDecoration(
              hintText: author.isEmpty? author.toString():"",
            ),
            initialValue: author.isEmpty? "" : author.toString(),
            validator: (text) {
              //Validates the [text] inserted.
              RegExp regExp =
                  RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
              if (!text.contains(' ') || !regExp.hasMatch(text))
                return Localization.of(context).authorErrorMessage;
              else
                return null;
            },
            onSaved: (text) {
              //When the form is saved, takes [text], splits it and fills [author].
              List<String> strings = text.split(' ');
              author.clear();
              author.name = strings.removeAt(0);
              author.surname = strings.removeLast();
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => setState(() {
              widget.authors.remove(author);
              _mapForms.remove(author);
            }),
          ),
        ),
      );
  }
}
