import 'package:cloud_firestore/cloud_firestore.dart';

class Author {
  String id;
  String name;
  String surname;
  bool isEmpty;

  Author({
    this.name,
    this.surname,
  }){
    isEmpty=true;
  }

  assimilate(DocumentSnapshot snap) {
    id = snap.documentID;
    name = snap['name'];
    surname = snap['surname'];
    isEmpty=false;
  }

  void clear() {
    name = '';
    surname = '';
    isEmpty=true;
  }

  @override
  String toString() =>
      '$name $surname';

  Author clone() {
    Author author = Author();
    author.id= id;
    author.name = this.name;
    author.surname = this.surname;
    author.isEmpty=this.isEmpty;
    return author;
  }
}
