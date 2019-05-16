import 'package:cloud_firestore/cloud_firestore.dart';

class Author {
  String name;
  String secondName;
  String surname;

  Author(
      {this.name,
      this.secondName,
      this.surname,}) {
  }
  
  assimilate(DocumentSnapshot snap) {
    name = snap['name'];
    if(snap['secondName']!=null)
      secondName = snap['secondName'];
    surname = snap['surname'];
  }

  @override
  String toString(){
    String string= name;
    if (secondName!=null)
      string= string + " " + secondName;
    string = string + " " + surname;
    return string;
  }
}
