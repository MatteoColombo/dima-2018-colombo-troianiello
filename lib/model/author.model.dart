import 'package:cloud_firestore/cloud_firestore.dart';

class Author {
  String name;
  String secondName;
  String surname;

  Author({
    this.name,
    this.secondName,
    this.surname,
  });

  assimilate(DocumentSnapshot snap) {
    name = snap['name'];
    if (snap['secondName'] != null) secondName = snap['secondName'];
    surname = snap['surname'];
  }

  void clear() {
    name = '';
    secondName = null;
    surname = '';
  }

  @override
  String toString() =>
      '$name ${(secondName != null) ? secondName : ""} $surname';

  Author clone() {
    Author author = Author();
    author.name = this.name;
    author.secondName = this.secondName;
    author.surname = this.surname;
    return author;
  }
}
