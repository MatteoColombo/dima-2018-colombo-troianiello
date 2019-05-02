import 'package:cloud_firestore/cloud_firestore.dart';

class Library {
  Library({this.name, this.isFavourite, this.reference, this.image});
  String name;
  bool isFavourite;
  String image;
  DocumentReference reference;

  assimilate(DocumentSnapshot snap) {
    name = snap['name'];
    isFavourite = snap['isFavourite'];
    image = snap['image'];
    reference = snap.reference;
  }
}
