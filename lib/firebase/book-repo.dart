import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/book.model.dart';
import '../model/author.model.dart';

class _BookControl {
  CollectionReference _collectionBook = Firestore.instance.collection("books");
  CollectionReference _collectionAuthors =
      Firestore.instance.collection("authors");
  CollectionReference _collectionCreations =
      Firestore.instance.collection("creations");

  Stream<Book> getBook(String isbn) async* {
    DocumentSnapshot book = await _collectionBook.document(isbn).get();
      Book modelBook = Book();
      modelBook.assimilate(book);
      QuerySnapshot creations= await _collectionCreations.where("book",isEqualTo: modelBook.isbn).getDocuments();
      for (DocumentSnapshot result in creations.documents) {
          DocumentSnapshot documentAuthor = await _collectionAuthors.document(result['author']).get();
          Author author= Author();
          author.assimilate(documentAuthor);
          modelBook.addAuthor(author);
      }
      yield modelBook;
    }
}

final _BookControl bookManager = _BookControl();
