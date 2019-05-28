import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/author.model.dart';

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
  List<Author> _authors;

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
    _authors = new List<Author>();
  }
  void assimilate(DocumentSnapshot snap) {
    isbn = snap.documentID;
    title = snap['title'];
    image = snap['image'];
    description = snap['description'];
    edition = snap['edition'];
    pages = snap['pages'];
    price = snap['price'];
    publisher = snap['publisher'];
    releaseDate = snap['releaseDate'].toDate();
  }

  void addAuthor(Author author) {
    _authors.add(author);
  }

  void deleteAuthor(Author author) {
    _authors.remove(author);
  }

  List<Author> get authors => _authors;

  Book clone() {
    Book book = Book();
    book.isbn = this.isbn;
    book.title = this.title;
    book.image = this.image;
    book.description = this.description;
    book.edition = this.edition;
    book.pages = this.pages;
    book.price = this.price;
    book.publisher = this.publisher;
    book.releaseDate = this.releaseDate;
    for (Author author in this._authors) {
      book.addAuthor(author.clone());
    }
    return book;
  }

  bool isEmpty() {
    return this.isbn == null;
  }
}
