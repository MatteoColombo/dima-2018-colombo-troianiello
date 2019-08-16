import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-informations.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/author.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test book informations", (WidgetTester tester) async {

    //The book to display
    Book book = Book(
      title: 'title',
      description: 'desc',
      edition: 'ed',
      image: 'url',
      isbn: '000',
      pages: 10,
      price: '100',
      publisher: 'pub',
      releaseDate: DateTime.utc(1970, 12, 20),
    );
    Author author = Author(name: 'a', surname: 'b');
    book.addAuthor(author);
    final Widget widget = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: Scaffold(
        body: BookInformations(book: book),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();

    //Tests if all are displayed
    expect(find.text('title'), findsOneWidget);
    expect(find.text('desc'), findsOneWidget);
    expect(find.text('ed'), findsOneWidget);
    expect(find.text('000'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);
    expect(find.text('pub'), findsOneWidget);
    expect(find.text('a b'), findsOneWidget);
    expect(find.text('Sunday, 20 December 1970'),findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
