import 'package:cloud_firestore/cloud_firestore.dart';
///Represents of a person, the creator's book.
class Author {
  ///Firestore identifier of this author.
  String id;
  ///Author's first name.
  String name;
  ///Author's last name.
  String surname;
  ///Indicates that the object is empty or has default values.
  bool isEmpty;

  ///Constructor of Author.
  ///
  ///Recevies [name], author's first name, [surname], author's last name.
  Author({
    this.name,
    this.surname,
  }){
    isEmpty=true;
  }
  ///Fills this author with new informations.
  ///
  ///This author assimilates informations contained in [snap].
  assimilate(DocumentSnapshot snap) {
    id = snap.documentID;
    name = snap['name'];
    surname = snap['surname'];
    isEmpty=false;
  }

  ///Resets the informations of this author.
  void clear() {
    name = '';
    surname = '';
    isEmpty=true;
  }

  ///Returns a string representation of this object.
  ///
  ///The string is a concatenation of [name] and [surname].
  @override
  String toString() =>
      '$name $surname';

  ///Returns an identical copy of this author. 
  Author clone() {
    Author author = Author();
    author.id= id;
    author.name = this.name;
    author.surname = this.surname;
    author.isEmpty=this.isEmpty;
    return author;
  }
}
