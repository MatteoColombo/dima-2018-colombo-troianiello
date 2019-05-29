import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import '../model/book.model.dart';
import '../model/author.model.dart';
import './auth.dart';

class _BookControl {
  CollectionReference _collectionBook = Firestore.instance.collection("books");
  CollectionReference _collectionAuthors =
      Firestore.instance.collection("authors");
  CollectionReference _collectionCreations =
      Firestore.instance.collection("creations");
  CollectionReference _collectionRequests =
      Firestore.instance.collection("requests");

  Stream<Book> getBook(String isbn) async* {
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
      yield modelBook;
    } catch (e) {
      yield Book();
    }
  }

  Future<void> saveReuqest(Book book) async {
    Map<String, dynamic> mapAuthors = Map<String, dynamic>();
    for (int i = 0; i < book.authors.length; i++) {
      mapAuthors.putIfAbsent('author$i', () => book.authors[i].toString());
    }
    String userId=await authService.getUserId();
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
      "pending":true,
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
