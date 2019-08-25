import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/book-list-row.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/row-popup-menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBook extends Mock implements BaseBook {}

void main() {
  testWidgets("Test long press and tap when not selected",
      (WidgetTester tester) async {
    MockBook book = MockBook();
    final Widget w = LibProvider(
      book: book,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: BookListRow(
          isSelected: false,
          onSelect: (isbn) => expect(isbn, "1234567890123"),
          selecting: false,
          library: "lib1",
          book: Book(
              title: "Titolo",
              isbn: "1234567890123",
              publisher: "Editore",
              image: ""),
        ),
      ),
      auth: null,
      library: null,
      picker: null,
      scanner: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(BookListRow), findsOneWidget);

    expect(find.text("Titolo"), findsOneWidget);
    expect(find.text("Editore"), findsOneWidget);

    await tester.longPress(find.text("Titolo"));
    await tester.pump();

    verifyNever(book.getBook(any));

    await tester.tap(find.text("Titolo"));
    await tester.pump();

    verify(book.getBook("1234567890123")).called(1);
  });

  testWidgets("Test long press and tap when selected",
      (WidgetTester tester) async {
    MockBook book = MockBook();
    final Widget w = LibProvider(
      book: book,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: BookListRow(
          isSelected: true,
          onSelect: (isbn) => expect(isbn, "1234567890123"),
          selecting: true,
          library: "lib1",
          book: Book(
              title: "Titolo",
              isbn: "1234567890123",
              publisher: "Editore",
              image: ""),
        ),
      ),
      auth: null,
      library: null,
      picker: null,
      scanner: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(BookListRow), findsOneWidget);

    await tester.tap(find.text("Titolo"));
    await tester.pump();
  });

  testWidgets("Test popup delete", (WidgetTester tester) async {
    MockBook book = MockBook();
    final Widget w = LibProvider(
      book: book,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: BookListRow(
          isSelected: false,
          onSelect: (isbn) => expect(isbn, "1234567890123"),
          selecting: false,
          library: "lib1",
          book: Book(
              title: "Titolo",
              isbn: "1234567890123",
              publisher: "Editore",
              image: ""),
        ),
      ),
      auth: null,
      library: null,
      picker: null,
      scanner: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(PopupMenuButton), findsOneWidget);

    await tester.tap(find.byType(RowPopUpMenu));
    await tester.pump();

    expect(find.byType(PopupMenuItem), findsNWidgets(2));
    await tester.tap(find.text("Delete Book"));
    await tester.pump();
  });
}
