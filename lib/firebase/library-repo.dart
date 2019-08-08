import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dima2018_colombo_troianiello/firebase/book-repo.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import '../model/library.model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import './auth.dart';

/// Service used to communicate with Firebase and to manage the library collection.
class _LibraryControl {
  CollectionReference _db = Firestore.instance.collection("libraries");

  ///Returns a stream that yields a [List<Library>] every time the libraty list changes.
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

  /// Returns the libraries owned by the user.
  ///
  /// Filters the library with ID specified as parameter.
  Future<List<Library>> getUserLibs(String filter) async {
    String userId = authService.getUserId();
    QuerySnapshot source =
        await _db.where("uid", isEqualTo: userId).getDocuments();
    List<Library> libs = [];
    if (source.documents.length > 0) {
      source.documents.forEach((DocumentSnapshot d) {
        Library l = Library();
        l.assimilate(d);
        libs.add(l);
      });
    }
    libs = libs.where((Library l) => l.id != filter).toList();
    return libs;
  }

  /// Updates the favourite state of a library.
  void updateFavouritePreference(String id, bool preference) {
    _db.document(id).updateData({'isFavourite': preference});
  }

  /// Saves a library.
  ///
  /// If the library ID is provided, the library is updated.
  /// If there is no library ID, a new library is created.
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

  /// Deletes the library received as parameter.
  void deleteLibrary(Library lib) {
    _db.document(lib.id).delete();
    if (lib.image != null) {
      FirebaseStorage.instance
          .getReferenceFromUrl(lib.image)
          .then((ref) => ref.delete());
    }
  }

  /// Uploads an image file to Firebase Storage.
  Future<String> uploadFile(File image) async {
    String uid = authService.getUserId();
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("libraries/$uid/${basename(image.path)}");
    StorageUploadTask uploadTask = ref.putFile(image);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  /// Returns a stream that yields the books belonging to the library passed as parameter.
  ///
  /// The stream yields a [List<Book>] which is obtained by converting a QuerySnapshot.
  Stream<List<Book>> getBooksStream(String library) async* {
    Stream<QuerySnapshot> source =
        _db.document(library).collection("owned_books").snapshots();

    await for (QuerySnapshot data in source) {
      List<Book> list = List<Book>();
      data.documents.forEach((DocumentSnapshot doc) {
        Book book = Book();
        book.assimilate(doc);
        list.add(book);
      });
      list.sort((a, b) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });

      yield list;
    }
  }

  /// Adds a book to a user library.
  ///
  /// Receives a [String] which is the ISBN of the book that needs to be added to the  library  represented by a [String] ID.
  /// Returns a [bool], true if the book was added. False otherwise.
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

  /// Checks if a book is already present in a library.
  ///
  /// Receives a [String] which is a book ISBN and a [String] library ID.
  /// Returns a [bool] true if the book is already in the library. False otherwise.
  Future<bool> getIfBookAlreadyThere(String isbn, String libraryId) async {
    DocumentSnapshot snap = await _db
        .document(libraryId)
        .collection("owned_books")
        .document(isbn)
        .get();
    return snap.exists;
  }

  /// Removes a single book from a library.
  ///
  /// Receives a [String] which is the ISBN of a book and a [String] that is the ID of the library from which is should be removed.
  deleteBookFromLibrary(String isbn, String libraryId) async {
    await _db
        .document(libraryId)
        .collection("owned_books")
        .document(isbn)
        .delete();
  }

  /// Deletes the selected libraries.
  ///
  /// Libraries should be passed as a [List<String>] that represents an array of library IDs.
  void deleteSelectedLibraries(List<String> libs) {
    libs.forEach((id) => _db.document(id).delete());
  }

  /// Moves book from a library to anohter.
  ///
  /// [List<String>] book is the list of the ISBNs of books that need to be moved.
  /// [String] currentLib is the ID of the library in which books are currently located.
  /// [String] newLib is the ID of the library in which books should be moved.
  void moveBooks(List<String> books, String currentLib, String newLib) {
    deleteBooksFromLibrary(books, currentLib);
    books.forEach((String book) {
      addBookToUserLibrary(book, newLib);
    });
  }

  /// Deletes books from a library.
  ///
  /// Receives a [List<Book>] which cotains ISBNs of books that need do be removed from a library and a [String] which is the ID of the library.
  void deleteBooksFromLibrary(List<String> books, String library) {
    books.forEach((book) => deleteBookFromLibrary(book, library));
  }
}

final _LibraryControl libManager = _LibraryControl();
