import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String isbn;
  String title;
  String image;
  String description;
  String edition;
  int pages;
  String price;
  String publisher;
  DateTime releaseDate;
  List<String> _authors;

  Book(
      {this.isbn,
      this.title,
      this.image,
      this.description,
      this.edition,
      this.pages,
      this.price,
      this.publisher,
      this.releaseDate}) {
    _authors = new List<String>();
  }
  assimilate(DocumentSnapshot snap) {
    isbn = snap.documentID;
    title = snap['title'];
    image = snap['image'];
    description = snap['description'];
    edition = snap['edition'];
    pages = snap['pages'];
    price = snap['price'];
    publisher = snap['publisher'];
    releaseDate = snap['releaseDate'];
  }

  void addAuthor(String author) {
    _authors.add(author);
  }

  void deleteAuthor(String author){
    _authors.remove(author);
  }

  List<String> get authors => _authors;
}
