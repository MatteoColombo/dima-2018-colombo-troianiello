import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dima2018_colombo_troianiello/firebase/book-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import '../model/library.model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import './auth.dart';

class _LibraryControl {
  CollectionReference _db = Firestore.instance.collection("libraries");

  Stream<List<Library>> getLibraryStream() async* {
    String userId = authService.getUserId();
    Stream<QuerySnapshot> source =
        _db.where("uid", isEqualTo: userId).snapshots();

    await for (QuerySnapshot data in source) {
      List<Library> libList = List<Library>();
      data.documents.forEach((DocumentSnapshot doc) {
        Library lib = Library();
        lib.assimilate(doc);
        libList.add(lib);
      });
      //Sort by preference and then by name
      libList.sort((a, b) {
        if (a.isFavourite && !b.isFavourite) return -1;
        if (b.isFavourite && !a.isFavourite) return 1;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      yield libList;
    }
  }

  void updateFavouritePreference(String id, bool preference) {
    _db.document(id).updateData({'isFavourite': preference});
  }

  Future<void> saveLibrary(Library lib) async {
    if (lib.id == null) {
      return _db.document().setData({
        "name": lib.name,
        "isFavourite": lib.isFavourite,
        "image": lib.image,
        "uid": authService.getUserId()
      });
    } else {
      return _db.document(lib.id).updateData({
        "name": lib.name,
        "isFavourite": lib.isFavourite,
        "image": lib.image,
        "uid": authService.getUserId()
      });
    }
  }

  void deleteLibrary(Library lib) {
    _db.document(lib.id).delete();
  }

  Future<String> uploadFile(File image) async {
    String uid = authService.getUserId();
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("libraries/$uid/${basename(image.path)}");
    StorageUploadTask uploadTask = ref.putFile(image);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<List<Book>> getBooks(Library library) async {
    QuerySnapshot snap =
        await _db.document(library.id).collection("owned_books").getDocuments();

    List<Book> books = [];
    print("idk");
    print(snap.documents.length);
    for (DocumentSnapshot doc in snap.documents) {
      Book b = Book();
      b.assimilate(doc);
      books.add(b);
    }
    return books;
  }

  Future<bool> addBookToUserLibrary(String isbn, String libraryId) async {
    Book book = await bookManager.getBook(isbn);
    if (book == null) return false;
    await _db
        .document(libraryId)
        .collection("owned_books")
        .document(isbn)
        .setData({
      "isbn": book.isbn,
      "releaseDate": book.releaseDate,
      "publisher": book.publisher,
      "title": book.title,
      "image": book.image
    });
    return true;
  }

  deleteBookFromLibrary(String isbn, String libraryId) async {
    await _db
        .document(libraryId)
        .collection("owned_books")
        .document(isbn)
        .delete();
  }
}

final _LibraryControl libManager = _LibraryControl();
