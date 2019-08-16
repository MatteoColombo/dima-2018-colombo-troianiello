import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-picker.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-edit-page/book-edit-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:mockito/mockito.dart';

class MockPicker extends Mock implements BasePicker {}

class MockBook extends Mock implements BaseBook {}

final BasePicker picker = new MockPicker();
final BaseBook book = new MockBook();

//Tests if the alert dialog is shown
void main() {
  testWidgets("Test alert dialog", (WidgetTester tester) async {
    final Widget widget = LibProvider(
      auth: null,
      book: book,
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

    //Inserts the information
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'), 'title');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Description'), 'desc');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Publisher'), 'pub');
    await tester.enterText(find.widgetWithText(TextFormField, 'Edition'), 'ed');
    await tester.enterText(find.widgetWithText(TextFormField, 'Price'), '000');
    await tester.enterText(find.widgetWithText(TextFormField, 'Pages'), '9');
    await tester.tap(find.byIcon(Icons.done));
    await tester.pump();

    //Tests if the Alert Dialog is shown
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(find.widgetWithText(FlatButton, 'CLOSE'));
  });

  //Edits a book
  testWidgets("Test book edit dialog", (WidgetTester tester) async {
    final Widget widget = LibProvider(
      auth: null,
      book: book,
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

    //Sets up the mocks
    when(picker.getImage(any, any, any))
        .thenAnswer((_) => Future.value(File("assets/images/google.png")));
    when(book.uploadFile(any,any))
      .thenAnswer((_) => Future.value("ciao"));
    
    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    
    //Inserts the image
    await tester.tap(find.byIcon(Icons.image));

    //Inserts the information
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'), 'title');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Description'), 'desc');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Publisher'), 'pub');
    await tester.enterText(find.widgetWithText(TextFormField, 'Edition'), 'ed');
    await tester.enterText(find.widgetWithText(TextFormField, 'Price'), '000');
    await tester.enterText(find.widgetWithText(TextFormField, 'Pages'), '9');
    await tester.tap(find.byIcon(Icons.done));

    //Takes the book edited and controls it
    Book b = verify(book.saveBook(captureAny)).captured.first;
    expect(b.title, 'title');
    expect(b.description, 'desc');
    expect(b.publisher, 'pub');
    expect(b.edition, 'ed');
    expect(b.price, '000');
    expect(b.pages, 9);
    expect(b.releaseDate != null, true);
    expect(b.image, 'ciao');
  });
}
