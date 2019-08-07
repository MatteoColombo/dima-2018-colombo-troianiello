import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/author.model.dart';

///Contains the characteristic informations of a book.
class Book {
  ///The identifier of this book.
  String isbn;
  ///The title of this book.
  String title;
  ///The URL of this cover.
  String image;
  ///A string giving the characteristics of this book.
  String description;
  ///The form or version in which this book is published.
  String edition;
  ///The total numeber of pages of this book.
  int pages;
  ///The cost of this book.
  String price;
  ///The company that has printed the book.
  String publisher;
  ///The date, when the book is officialy published.
  DateTime releaseDate;
  ///Indicates whether the book should be checked on the signatory.
  bool toCheck;
  ///The creators of the book.
  List<Author> _authors;
  
  ///Constructor of Book.
  ///
  ///Recevies [isbn], the identifier, [title], [image], the URL of the cover, 
  ///[description], a string giving the characteristics of this book, [edition],
  ///the form or version in which this book is published, [pages], the total numeber of pages,
  ///[price], the cost, [publisher], the company that has printed this book,
  ///[releaseDate], when is officialy published.
  Book(
      {this.isbn,
      this.title,
      this.image,
      this.description,
      this.edition,
      this.pages,
      this.price,
      this.publisher,
      this.releaseDate,}) {
    toCheck = true;
    if(releaseDate==null)releaseDate= DateTime.now();
    _authors = new List<Author>();
  }

  ///Fills this book with new informations.
  ///
  ///This book assimilates informations contained in [snap].
  void assimilate(DocumentSnapshot snap) {
    isbn = snap.documentID;
    title = snap['title'];
    image = snap['image'];
    description = snap['description'];
    edition = snap['edition'];
    pages = snap['pages'];
    price = snap['price'];
    publisher = snap['publisher'];
    toCheck = snap['toCheck'];
    releaseDate = snap['releaseDate'].toDate();
  }

  ///Adds a new creator of this book.
  ///
  ///Receives the new [author] to add.
  void addAuthor(Author author) {
    _authors.add(author);
  }

  ///Removes a specific author.
  ///
  ///Receives the [author] to remove.
  void deleteAuthor(Author author) {
    _authors.remove(author);
  }

  ///Returns the list of all authors.
  List<Author> get authors => _authors;

  ///Returns an identical copy of this book. 
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

  ///Indicates that this object is empty.
  bool isEmpty() {
    return this.isbn == null;
  }
}
