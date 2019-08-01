import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import '../model/book.model.dart';
import '../model/author.model.dart';
import '../model/review.model.dart';
import './auth.dart';

class _BookControl {
  CollectionReference _collectionBook = Firestore.instance.collection("books");
  CollectionReference _collectionAuthors =
      Firestore.instance.collection("authors");
  CollectionReference _collectionCreations =
      Firestore.instance.collection("creations");
  CollectionReference _collectionRequests =
      Firestore.instance.collection("requests");

  Future<Book> getBook(String isbn) async {
    try {
      DocumentSnapshot book = await _collectionBook.document(isbn).get();
      Book modelBook = Book();
      modelBook.assimilate(book);
      QuerySnapshot creations = await _collectionCreations
          .where("book", isEqualTo: modelBook.isbn)
          .getDocuments();
      for (DocumentSnapshot result in creations.documents) {
        DocumentSnapshot documentAuthor =
            await _collectionAuthors.document(result['author']).get();
        Author author = Author();
        author.assimilate(documentAuthor);
        modelBook.addAuthor(author);
      }
      return modelBook;
    } catch (e) {
      return Book();
    }
  }

  Stream<List<Review>> getReviews(String isbn) async* {
    List<Review> reviews;
    Stream<QuerySnapshot> reviewsSnapshot =
        _collectionBook.document(isbn).collection("reviews").snapshots();
    await for (QuerySnapshot result in reviewsSnapshot) {
      reviews = new List<Review>();
      result.documents.forEach((DocumentSnapshot document) {
        Review review = new Review();
        review.assimilate(document);
        reviews.add(review);
      });
      reviews.sort((a,b){
        return -(a.date.compareTo(b.date));
      });
      yield reviews;
    }
  }

  Future<void> saveRequest(Book book) async {
    Map<String, dynamic> mapAuthors = Map<String, dynamic>();
    for (int i = 0; i < book.authors.length; i++) {
      mapAuthors.putIfAbsent('author$i', () => book.authors[i].toString());
    }
    String userId = await authService.getUserId();
    _collectionRequests.document('${book.isbn}_$userId').setData({
      "user": userId,
      "isbn": book.isbn,
      "requestDate": DateTime.now(),
      "title": book.title,
      "image": book.image,
      "description": book.description,
      "edition": book.edition,
      "publisher": book.publisher,
      "pages": book.pages,
      "price": book.price,
      "releaseDate": book.releaseDate,
      "authors": mapAuthors,
      "pending": true,
    });
  }

  Future<void> saveReview(Review review, String isbn) async {
    String userId = await authService.getUserId();
    String userName = await authService.getUserName();
    List<String> strings = userName.split(' ');
    String initials = strings.removeAt(0)[0] + strings.removeLast()[0];
    _collectionBook
        .document(isbn)
        .collection('reviews')
        .document('review_$userId')
        .setData({
      "date": DateTime.now(),
      "score": review.score,
      "text": review.text,
      "user": initials,
      "userId": userId,
    });
  }

  Future<String> uploadFile(File image) async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("books/requests/${basename(image.path)}");
    StorageUploadTask uploadTask = ref.putFile(image);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
}

final _BookControl bookManager = _BookControl();
