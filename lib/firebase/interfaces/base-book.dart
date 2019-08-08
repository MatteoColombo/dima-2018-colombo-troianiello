import 'dart:io';

import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/review.model.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';

abstract class BaseBook {
  Future<Book> getBook(String isbn);
  Future<Review> getUserReview(String isbn, String uid);
  Future<List<Review>> getOtherReviews(String isbn, String uid);
  Future<void> saveBook(Book book);
  Future<void> saveRequest(Book book, String uid);
  Future<Review> saveReview(Review review, String isbn, User user);
  Future<String> uploadFile(File image, bool request);
  Future<List<Book>> searchBooks(String query);
}
