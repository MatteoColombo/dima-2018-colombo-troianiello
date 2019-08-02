import 'package:cloud_firestore/cloud_firestore.dart';

class Library {
  Library({
    this.name,
    this.isFavourite,
    this.reference,
    this.image,
    this.bookCount,
  });
  String name;
  bool isFavourite;
  String image;
  int bookCount;
  DocumentReference reference;

  assimilate(DocumentSnapshot snap) {
    name = snap['name'];
    isFavourite = snap['isFavourite'] ?? false;
    image = snap['image'];
    bookCount = snap['bookCount'] ?? 0;
    reference = snap.reference;
  }
}
