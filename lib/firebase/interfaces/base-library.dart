import 'dart:io';

import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseLibrary {
  Stream<List<Library>> getLibraryStream(String uid);
  Future<List<Library>> getUserLibraries(String filter, String uid);
  Future<void> updateUserFavouritePreference(String library, bool preference);
  Future<void> saveLibrary(Library library, String uid);
  Future<void> deleteLibrary(Library library);
  Future<String> uploadFile(File image, String uid);
  Stream<List<Book>> getBooksStream(String library);
  Future<bool> addBookToUserLibrary(
      String isbn, String library, BuildContext context);
  Future<bool> getIfBookAlreadyThere(String isbn, String library);
  Future<void> deleteBookFromLibrary(String isbn, String library);
  Future<void> deleteSelectedLibraries(List<String> libraries);
  Future<void> moveBooks(List<String> books, String currentLib, String newLib,
      BuildContext contexst);
  Future<void> deleteBooksFromLibrary(List<String> books, String library);
}
