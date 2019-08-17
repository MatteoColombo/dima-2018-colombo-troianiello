import 'package:dima2018_colombo_troianiello/interfaces/base-auth.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-library.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-scanner.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-edit-page/book-edit-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/add-book-float.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockScanner extends Mock implements BaseScanner {}

class MockLibrary extends Mock implements BaseLibrary {}

class MockBook extends Mock implements BaseBook {}

class MockAuth extends Mock implements BaseAuth {}

void main() {
  testWidgets("Test the floating action button to add a book to a library",
      (WidgetTester tester) async {
    MockScanner scanner = MockScanner();
    MockLibrary library = MockLibrary();
    MockBook book = MockBook();
    MockAuth auth = MockAuth();

    when(auth.getUserId()).thenReturn("1");

    final Widget w = LibProvider(
      auth: auth,
      book: book,
      library: library,
      picker: null,
      scanner: scanner,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
          floatingActionButton: AddBookFloat(
            libraryId: "lib1",
          ),
        ),
      ),
    );

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(FloatingActionButton), findsOneWidget);

    when(scanner.getISBN(any)).thenReturn(null);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    verify(scanner.getISBN(any)).called(1);

    when(scanner.getISBN(any)).thenAnswer((_) async => "ciaone");
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    verify(scanner.getISBN(any)).called(1);
    verifyNever(library.getIfBookAlreadyThere(any, any));
    expect(find.byType(SnackBar), findsOneWidget);

    when(scanner.getISBN(any)).thenAnswer((_) async => "1234567890123");
    when(library.getIfBookAlreadyThere(any, any)).thenAnswer((_) async => true);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    verify(scanner.getISBN(any)).called(1);
    verify(library.getIfBookAlreadyThere(any, any)).called(1);
    verifyNever(library.addBookToUserLibrary(any, any, any));

    when(scanner.getISBN(any)).thenAnswer((_) async => "1234567890123");
    when(library.getIfBookAlreadyThere(any, any))
        .thenAnswer((_) async => false);
    when(library.addBookToUserLibrary(any,any, any))
        .thenAnswer((_) async => true);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    verify(scanner.getISBN(any)).called(1);
    verify(library.getIfBookAlreadyThere(any, any)).called(1);
    verify(library.addBookToUserLibrary(any, any, any)).called(1);

        when(scanner.getISBN(any)).thenAnswer((_) async => "1234567890123");
    when(library.getIfBookAlreadyThere(any, any))
        .thenAnswer((_) async => false);
    when(library.addBookToUserLibrary(any,any, any))
        .thenAnswer((_) async => false);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    verify(scanner.getISBN(any)).called(1);
    verify(library.getIfBookAlreadyThere(any, any)).called(1);
    verify(library.addBookToUserLibrary(any, any, any)).called(1);



  });
}
