import 'package:cloud_firestore/cloud_firestore.dart';

class Author {
  String id;
  String name;
  String surname;

  Author({
    this.name,
    this.surname,
  });

  assimilate(DocumentSnapshot snap) {
    id = snap.documentID;
    name = snap['name'];
    surname = snap['surname'];
  }

  void clear() {
    name = '';
    surname = '';
  }

  @override
  String toString() =>
      '$name $surname';

  Author clone() {
    Author author = Author();
    author.id= id;
    author.name = this.name;
    author.surname = this.surname;
    return author;
  }
}
