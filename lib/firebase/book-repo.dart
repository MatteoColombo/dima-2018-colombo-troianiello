import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dima2018_colombo_troianiello/firebase/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import '../model/book.model.dart';
import '../model/author.model.dart';
import '../model/review.model.dart';

class BookRepo extends BaseBook {
  CollectionReference _collectionBook = Firestore.instance.collection("books");
  CollectionReference _collectionAuthors =
      Firestore.instance.collection("authors");
  CollectionReference _collectionRequests =
      Firestore.instance.collection("requests");

  Future<Book> getBook(String isbn) async {
    Book modelBook = Book();
    try {
      DocumentSnapshot book = await _collectionBook.document(isbn).get();
      if (!book.exists) return null;
      modelBook.assimilate(book);
      QuerySnapshot authors = await _collectionBook
          .document(isbn)
          .collection('authors')
          .getDocuments();
      for (DocumentSnapshot documentAuthor in authors.documents) {
        Author author = Author();
        author.assimilate(documentAuthor);
        modelBook.addAuthor(author);
      }
      return modelBook;
    } catch (e) {
      return Book();
    }
  }

  Future<Review> getUserReview(String isbn, String uid) async {
    DocumentSnapshot document = await _collectionBook
        .document(isbn)
        .collection("reviews")
        .document('review_$uid')
        .get();
    Review review = new Review();
    if (document.exists) review.assimilate(document);
    return review;
  }

  Future<List<Review>> getOtherReviews(String isbn, String uid) async {
    List<Review> reviews = new List<Review>();
    QuerySnapshot reviewsSnapshot = await _collectionBook
        .document(isbn)
        .collection("reviews")
        .getDocuments();
    for (DocumentSnapshot document in reviewsSnapshot.documents) {
      Review review = new Review();
      review.assimilate(document);
      reviews.add(review);
    }
    reviews = reviews.where((review) => review.userId != uid).toList();
    return reviews;
  }

  Future<void> saveBook(Book book) async {
    for (Author author in book.authors) {
      QuerySnapshot results = await _collectionAuthors
          .where(
            'name',
            isEqualTo: author.name,
          )
          .where('surname', isEqualTo: author.surname)
          .getDocuments();
      if (results.documents.length == 0) {
        Map<String, dynamic> mapAuthorData = Map<String, dynamic>();
        mapAuthorData.addAll({
          'name': author.name,
          'surname': author.surname,
        });
        await _collectionAuthors.document().setData(mapAuthorData);
        QuerySnapshot newResults = await _collectionAuthors
            .where(
              'name',
              isEqualTo: author.name,
            )
            .where('surname', isEqualTo: author.surname)
            .getDocuments();
        author.id = newResults.documents.first.documentID;
      } else
        author.id = results.documents.first.documentID;
    }

    await _collectionBook.document('${book.isbn}').setData({
      "title": book.title,
      "title_low": book.title.toLowerCase(),
      "image": book.image,
      "description": book.description,
      "edition": book.edition,
      "publisher": book.publisher,
      "pages": book.pages,
      "price": book.price,
      "releaseDate": book.releaseDate,
      "toCheck": true,
    });
    for (Author author in book.authors) {
      _collectionBook
          .document('${book.isbn}')
          .collection('authors')
          .document('${author.id}')
          .setData({
        "name": author.name,
        "surname": author.surname,
      });
    }
  }

  Future<void> saveRequest(Book book, String uid) async {
    _collectionRequests.document('${book.isbn}_$uid').setData({
      "user": uid,
      "isbn": book.isbn,
      "requestDate": DateTime.now(),
      "title": book.title,
      "title_low": book.title.toLowerCase(),
      "image": book.image,
      "description": book.description,
      "edition": book.edition,
      "publisher": book.publisher,
      "pages": book.pages,
      "price": book.price,
      "releaseDate": book.releaseDate,
      "pending": true,
    });
    for (int i = 0; i < book.authors.length; i++) {
      _collectionRequests
          .document('${book.isbn}_$uid')
          .collection('authors')
          .document('author$i')
          .setData({
        'user': book.authors[i].name,
        'surname': book.authors[i].surname,
      });
    }
  }

  Future<Review> saveReview(Review review, String isbn, User user) async {
    await _collectionBook
        .document(isbn)
        .collection('reviews')
        .document('review_${user.id}')
        .setData({
      "date": DateTime.now(),
      "score": review.score,
      "text": review.text,
      "user": user.initials,
      "userId": user.id,
    });
    return this.getUserReview(isbn, user.id);
  }

  Future<String> uploadFile(File image, bool request) async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("books/${request ? "requests/" : ""}${basename(image.path)}");
    StorageUploadTask uploadTask = ref.putFile(image);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<List<Book>> searchBooks(String query) async {
    query = query.toLowerCase();
    QuerySnapshot res = await _collectionBook
        .orderBy("title_low")
        .where("title_low", isGreaterThanOrEqualTo: query)
        .where("title_low", isLessThanOrEqualTo: query + "z")
        .getDocuments();
    if (res.documents.length > 0) {
      List<Book> books = [];
      res.documents.forEach((doc) {
        Book b = Book();
        b.assimilate(doc);
        books.add(b);
      });
      return books;
    }
    return [];
  }
}
