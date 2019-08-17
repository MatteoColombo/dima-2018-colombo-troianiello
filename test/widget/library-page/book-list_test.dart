import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/book-list-row.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/book-list.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/sort-books-enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBook extends Mock implements BaseBook {}

void main() {
  List<Book> _books = [
    Book(isbn: "1",title: "B1",image: "",publisher: "P1",releaseDate: DateTime(1234567)),
    Book(isbn: "1",title: "B2",image: "",publisher: "P1",releaseDate: DateTime(1234570)),
    Book(isbn: "1",title: "B3",image: "",publisher: "P1",releaseDate: DateTime(1234560)),
    Book(isbn: "1",title: "B4",image: "",publisher: "P1",releaseDate: DateTime(1234567)),
  ];

  testWidgets("Test book list when books are not null",
      (WidgetTester tester) async {
    MockBook book = MockBook();
    final Widget w = LibProvider(
      book: book,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: BookList(
          library: "lib1",
          selected: [],
          sort: SortMethods.TitleReverse,
          books: null,
          onSelect: () => null,
        ),
      ),
      auth: null,
      library: null,
      picker: null,
      scanner: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();
  
    expect(find.byType(CircularProgressIndicator),findsOneWidget);
  });

    testWidgets("Test book list with title sort",
      (WidgetTester tester) async {
    MockBook book = MockBook();
    final Widget w = LibProvider(
      book: book,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: BookList(
          library: "lib1",
          selected: [],
          sort: SortMethods.Title,
          books: _books,
          onSelect: () => null,
        ),
      ),
      auth: null,
      library: null,
      picker: null,
      scanner: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();
  
    expect(find.byType(BookListRow),findsNWidgets(4));
    expect((find.byType(Text).first.evaluate().single.widget as Text).data, "B1");
  });

  testWidgets("Test book list with reverse title sort",
      (WidgetTester tester) async {
    MockBook book = MockBook();
    final Widget w = LibProvider(
      book: book,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: BookList(
          library: "lib1",
          selected: [],
          sort: SortMethods.TitleReverse,
          books: _books,
          onSelect: () => null,
        ),
      ),
      auth: null,
      library: null,
      picker: null,
      scanner: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();
  
    expect(find.byType(BookListRow),findsNWidgets(4));
    expect((find.byType(Text).first.evaluate().single.widget as Text).data, "B4");
  });


  testWidgets("Test book list with oldest sort",
      (WidgetTester tester) async {
    MockBook book = MockBook();
    final Widget w = LibProvider(
      book: book,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: BookList(
          library: "lib1",
          selected: [],
          sort: SortMethods.Oldest,
          books: _books,
          onSelect: () => null,
        ),
      ),
      auth: null,
      library: null,
      picker: null,
      scanner: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();
  
    expect(find.byType(BookListRow),findsNWidgets(4));
    expect((find.byType(Text).first.evaluate().single.widget as Text).data, "B3");
  });


  testWidgets("Test book list with newest sort",
      (WidgetTester tester) async {
    MockBook book = MockBook();
    final Widget w = LibProvider(
      book: book,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: BookList(
          library: "lib1",
          selected: [],
          sort: SortMethods.Newest,
          books: _books,
          onSelect: () => null,
        ),
      ),
      auth: null,
      library: null,
      picker: null,
      scanner: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();
  
    expect(find.byType(BookListRow),findsNWidgets(4));
    expect((find.byType(Text).first.evaluate().single.widget as Text).data, "B2");
  });
}
