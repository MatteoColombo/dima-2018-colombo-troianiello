import 'dart:io';

import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/review.model.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';

///Abstrac class of the service used to communicate with Firestore and to manage the books.
abstract class BaseBook {
  ///Returns [Book] from Firestore collection.
  ///
  ///[isbn] is the identifier of this [Book].
  Future<Book> getBook(String isbn);

  ///Returns the [Review] of the book made by the user.
  ///
  ///[isbn] is the identifier of this book and
  ///[userId] is the identifier of the user, who made the [Review].
  Future<Review> getUserReview(String isbn, String userId);

  ///Returns the [List] of [Review]s of the book, made by all other users.
  ///
  ///[isbn] is the identifier of this book and
  ///[userId] is the identifier of the user to be excluded.
  Future<List<Review>> getOtherReviews(String isbn, String userId);

  ///Saves [book] in the Books collection.
  Future<void> saveBook(Book book);

  ///Saves the request in Requests collection.
  ///
  ///[book] contains of changes of the request and
  ///[userId] is the user, who made the request.
  Future<void> saveRequest(Book book, String userId);

  ///Saves this [review] in Reviews collection.
  ///
  ///[review] is the comment made by [user] and
  ///[isbn] is the identifier of the book associated to this [review].
  Future<Review> saveReview(Review review, String isbn, User user);

  ///Saves the [image] on the Storege of Firestore.
  ///
  ///[image] is the image to save.
  ///[request] indicates where [image] will be save. If [request] is true,
  ///[image] will be save in the Reuqests folder,
  ///otherwise it will be save in the Books folder.
  Future<String> uploadFile(File image, bool request);

  ///Searches the specific books using [query] on Firestore.
  ///
  ///Returns a [List] of [Book]s.
  ///[query] is a string that used to perform the query.
  Future<List<Book>> searchBooks(String query);
}
