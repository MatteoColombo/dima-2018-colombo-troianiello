import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/search/search-item.dart';
import 'package:dima2018_colombo_troianiello/view/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBook extends Mock implements BaseBook {}

void main() {
  testWidgets("Test the search page when the query is null",
      (WidgetTester tester) async {
    final MockBook book = MockBook();
    final Widget w = LibProvider(
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
            body: Search(
          query: "",
        )),
      ),
      auth: null,
      library: null,
      book: book,
      scanner: null,
      picker: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.pump();

    verifyNever(book.searchBooks(any));
  });

  testWidgets("Test the search page when there is no match",
      (WidgetTester tester) async {
    final MockBook book = MockBook();
    final Widget w = LibProvider(
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
            body: Search(
          query: "s",
        )),
      ),
      auth: null,
      library: null,
      book: book,
      scanner: null,
      picker: null,
    );

    when(book.searchBooks("s")).thenAnswer((_) async => []);

    await tester.pumpWidget(w);
    await tester.pump();

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    verify(book.searchBooks("s")).called(1);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets("Test the search page when there are two matches",
      (WidgetTester tester) async {
    final MockBook book = MockBook();
    final Widget w = LibProvider(
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
            body: Search(
          query: "s",
        )),
      ),
      auth: null,
      library: null,
      book: book,
      scanner: null,
      picker: null,
    );

    when(book.searchBooks("s")).thenAnswer((_) async => [
          Book(isbn: "123", title: "B1", publisher: "P1", image: ""),
          Book(isbn: "456", title: "B2", publisher: "P2", image: ""),
        ]);

    await tester.pumpWidget(w);
    await tester.pump();

    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    verify(book.searchBooks("s")).called(1);
    expect(find.byType(Image), findsNothing);
    expect(find.byType(SearchItem), findsNWidgets(2));
  });
}
