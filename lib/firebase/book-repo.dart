import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import '../model/book.model.dart';
import '../model/author.model.dart';
import '../model/review.model.dart';

///Service used to communicate with Firestore and to manage the books.
class BookRepo extends BaseBook {
  ///The reference to the Books collection on Firestore.
  CollectionReference _collectionBook = Firestore.instance.collection("books");

  ///The reference to the Authors collection on Firestore.
  CollectionReference _collectionAuthors =
      Firestore.instance.collection("authors");

  ///The reference to the Requests collection on Firestore.
  CollectionReference _collectionRequests =
      Firestore.instance.collection("requests");

  ///Returns [Book] from Firestore collection.
  ///
  ///[isbn] is the identifier of this [Book].
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

  ///Returns the [Review] of the book made by the user.
  ///
  ///[isbn] is the identifier of this book and
  ///[userId] is the identifier of the user, who made the [Review].
  Future<Review> getUserReview(String isbn, String userId) async {
    DocumentSnapshot document = await _collectionBook
        .document(isbn)
        .collection("reviews")
        .document('review_$userId')
        .get();
    Review review = new Review();
    if (document.exists) review.assimilate(document);
    return review;
  }

  ///Returns the [List] of [Review]s of the book, made by all other users.
  ///
  ///[isbn] is the identifier of this book and
  ///[userId] is the identifier of the user to be excluded.
  Future<List<Review>> getOtherReviews(String isbn, String userId) async {
    List<Review> reviews = new List<Review>();
    QuerySnapshot reviewsSnapshot = await _collectionBook
        .document(isbn)
        .collection("reviews")
        .getDocuments();
    for (DocumentSnapshot document in reviewsSnapshot.documents) {
      Review review = new Review();
      review.assimilate(document);
      if (review.userId != userId) reviews.add(review);
    }
    return reviews;
  }

  ///Saves [book] in the Books collection.
  Future<void> saveBook(Book book) async {
    try {
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
    } catch (e) {}
  }

  ///Saves the request in Requests collection.
  ///
  ///[book] contains of changes of the request and 
  ///[userId] is the user, who made the request.
  Future<void> saveRequest(Book book, String userId) async {
    _collectionRequests.document('${book.isbn}_$userId').setData({
      "user": userId,
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
          .document('${book.isbn}_$userId')
          .collection('authors')
          .document('author$i')
          .setData({
        'user': book.authors[i].name,
        'surname': book.authors[i].surname,
      });
    }
  }

  ///Saves this [review] in Reviews collection.
  ///
  ///[review] is the comment made by [user] and 
  ///[isbn] is the identifier of the book associated to this [review].
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

  ///Saves the [image] on the Storege of Firestore.
  ///
  ///[image] is the image to save. 
  ///[request] indicates where [image] will be save. If [request] is true, 
  ///[image] will be save in the Reuqests folder, 
  ///otherwise it will be save in the Books folder.
  Future<String> uploadFile(File image, bool request) async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("books/${request ? "requests/" : ""}${basename(image.path)}");
    StorageUploadTask uploadTask = ref.putFile(image);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  ///Searches the specific books using [query] on Firestore.
  ///
  ///Returns a [List] of [Book]s.
  ///[query] is a string that used to perform the query.
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
