import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-picker.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/review.model.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-edit-page/book-edit-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Picker extends BasePicker {
  Future<File> getImage(double width, double height, ImageSource type) async {
    return File("assets/images/google.png");
  }
}
class BookR extends BaseBook {
  Book book;
  Future<Book> getBook(String isbn) async {
    return book;
  }
  Future<Review> getUserReview(String isbn, String userId) async {
    return null;
  }
  Future<List<Review>> getOtherReviews(String isbn, String userId) async {
    return null;
  }
  Future<void> saveBook(Book book) async {
    this.book=book;
  }
  Future<void> saveRequest(Book book, String userId) async {
  }
  Future<Review> saveReview(Review review, String isbn, User user) async {
    return null;
  }
  Future<String> uploadFile(File image, bool request) async {
    return "ciao";
  }
  Future<List<Book>> searchBooks(String query) {
    return null;
  }
}

void main() {
  testWidgets("Test book edit dialog", (WidgetTester tester) async {
    final BasePicker picker= new Picker();
    final BaseBook _book= new BookR();
    final Widget widget = LibProvider(
      auth: null,
      book: _book,
      library: null,
      picker: picker,
      scanner: null,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
          body: BookEditDialog(isbn: '000'),
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    await tester.tap(find.byIcon(Icons.image));
    await tester.enterText(find.widgetWithText(TextFormField,'Title'), 'title');
    await tester.enterText(find.widgetWithText(TextFormField,'Description'), 'desc');
    await tester.enterText(find.widgetWithText(TextFormField,'Publisher'), 'pub');
    await tester.enterText(find.widgetWithText(TextFormField,'Edition'), 'ed');
    await tester.enterText(find.widgetWithText(TextFormField,'Price'), '000');
    await tester.enterText(find.widgetWithText(TextFormField,'Pages'), '9');
    await tester.tap(find.byIcon(Icons.done));
    Book b=await _book.getBook('');
    expect(b.title, 'title');
    expect(b.description, 'desc');
    expect(b.publisher, 'pub');
    expect(b.edition, 'ed');
    expect(b.price, '000');
    expect(b.pages, 9);
    expect(b.releaseDate!=null,true);
    expect(b.image, 'ciao');
  });
}
