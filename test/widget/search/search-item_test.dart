import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-auth.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-library.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/loading-spinner.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/move-book-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/search/search-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLibrary extends Mock implements BaseLibrary {}

class MockAuth extends Mock implements BaseAuth {}

class MockBook extends Mock implements BaseBook {}

// Test Search item and move book dialog
void main() {
  testWidgets("test a search list item and the move book dialog",
      (WidgetTester tester) async {
    final Book b = Book(
      image:
          "https://www.incimages.com/uploaded_files/image/970x450/getty_883231284_200013331818843182490_335833.jpg",
      title: "Titolo",
      isbn: "1234567890123",
      publisher: "publisher",
    );
    final MockAuth auth = MockAuth();
    final MockLibrary library = MockLibrary();
    final MockBook book = MockBook();

    final Widget w = LibProvider(
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
          body: SearchItem(
            book: b,
          ),
        ),
      ),
      auth: auth,
      library: library,
      book: book,
      scanner: null,
      picker: null,
    );

    // Mock user ID and library list.
    when(auth.getUserId()).thenReturn("1");
    when(library.getUserLibraries("", "1")).thenAnswer((_) async => [
          Library(
              bookCount: 1,
              name: "Lib 1",
              id: "lib1",
              image: null,
              isFavourite: false),
          Library(
              bookCount: 1,
              name: "Lib 2",
              id: "lib2",
              image: null,
              isFavourite: false),
        ]);

    // Create the widget.
    await tester.pumpWidget(w);

    // Wait for the widget to render and then verify that it was created.
    await tester.pump();
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.text("publisher"), findsOneWidget);
    expect(find.text("Titolo"), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);

    // Tap on the button to add the book.
    await tester.tap(find.byType(IconButton));

    // Wait for render and then verify that there is a loading spinner.
    await tester.pump();
    expect(find.byType(MoveBookDialog), findsOneWidget);
    expect(find.byType(LoadingSpinner), findsOneWidget);

    // Wait again and verify that there is a SimpleDialog with 2 options.
    await tester.pump();
    expect(find.byType(SimpleDialogOption), findsNWidgets(2));
    // Tap on the first option.
    await tester.tap(find.byType(SimpleDialogOption).first);

    // Wait and then verify that there was an attempt to save the book in lib1.
    await tester.pump();
    verify(auth.getUserId()).called(1);
    verify(library.getUserLibraries("", "1")).called(1);
    verify(library.addBookToUserLibrary("1234567890123", "lib1", any))
        .called(1);
    // Tap again on the add book icon button
    await tester.tap(find.byType(IconButton));

    // Wait for the Simple dialog to load and the click outside the dialog.
    await tester.pump();
    await tester.pump();
    expect(find.byType(SimpleDialogOption), findsNWidgets(2));
    await tester.tap(find.byType(Text).first);

    // Wait and thene verify that the book was not saved.
    await tester.pump();
    expect(find.byType(MoveBookDialog), findsNothing);
    verify(auth.getUserId()).called(1);
    verify(library.getUserLibraries("", "1")).called(1);
    verifyNever(library.addBookToUserLibrary("1234567890123", any, any));

    // Tap on the book
    await tester.tap(find.byType(CachedNetworkImage));

    // Wait for the book to load
    await tester.pump();
    // Verify that the book page requested the right book.
    verify(book.getBook("1234567890123")).called(1);
  });
}
