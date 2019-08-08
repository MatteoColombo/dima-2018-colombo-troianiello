import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class that represents libraries.
class Library {
  Library({
    this.name,
    this.isFavourite,
    this.id,
    this.image,
    this.bookCount,
  });
  String name;
  bool isFavourite;
  String image;
  int bookCount;
  String id;

  /// Populate the library.
  ///
  /// Takes a [DocumentSnapshot] and populates the fields of the library.
  assimilate(DocumentSnapshot snap) {
    name = snap['name'];
    isFavourite = snap['isFavourite'] ?? false;
    image = snap['image'];
    bookCount = snap['bookCount'] ?? 0;
    id = snap.documentID;
  }
}
