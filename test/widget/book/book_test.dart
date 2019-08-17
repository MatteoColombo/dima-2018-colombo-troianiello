import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-picker.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/review.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-edit-page/book-edit-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/book/book.dart';
import 'package:dima2018_colombo_troianiello/view/book/reviews-page/reviews-widget.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/book/book-informations.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/author.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'reviews-page/reviews-widget_test.dart';

class MockPicker extends Mock implements BasePicker {}

class MockBook extends Mock implements BaseBook {}

final BasePicker picker = new MockPicker();
final BaseBook book = new MockBook();

void main() {

  testWidgets("Test book page", (WidgetTester tester) async {

    //The book to display
    Book _book = Book(
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
    _book.addAuthor(author);

    //The user's empty review
    Review r=new Review();

    //The other reviews
    Review r1=new Review();
    r1.score=2;
    r1.text='primo';
    r1.date=DateTime(1970,12,20);
    r1.user='ST';
    r1.userId='2';
    
    final Widget widget = LibProvider(
      auth: auth,
      book: book,
      library: null,
      picker: null,
      scanner: null,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        locale: Locale('it'),
        home: Scaffold(
          body: BookPage(isbn: '000'),
        ),
      ),
    );
    
    //Sets up the mocks
    when(book.getUserReview(any,any))
        .thenAnswer((_) => Future.value(r));
    when(book.getOtherReviews(any,any))
        .thenAnswer((_) => Future.value([r1]));
    when(auth.getUserId())
        .thenAnswer((_) => '0');
    when(book.getBook(any))
      .thenAnswer((_) => Future.value(_book));

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    await tester.pump();

    //Tests if BookInformations is displayed
    expect(find.byType(BookInformations), findsOneWidget);
    expect(find.byType(ReviewsWidget), findsNothing);
    expect(find.byType(BookEditDialog), findsNothing);
    expect(find.byType(TabBar), findsOneWidget);
    expect(find.widgetWithIcon(Tab,Icons.comment),findsOneWidget);
    expect(find.byIcon(Icons.help_outline), findsOneWidget);

    //Opens the BookEditDialog
    await tester.tap(find.byIcon(Icons.help_outline));
    await tester.pump();
    await tester.pump();
    await tester.pump(Duration(seconds:1));

    //Tests if BookEditDialog is displayed
    expect(find.byType(BookInformations), findsNothing);
    expect(find.byType(ReviewsWidget), findsNothing);
    expect(find.byType(BookEditDialog), findsOneWidget);

    //Closes the dialog
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    await tester.pump();

    //Changes the page
    await tester.tap(find.widgetWithIcon(Tab,Icons.comment));
    await tester.pump();
    await tester.pump();
    await tester.pump(Duration(seconds:1));

    //Tests if ReviewsWidget is displayed
    expect(find.byType(BookInformations), findsNothing);
    expect(find.byType(ReviewsWidget), findsOneWidget);
    expect(find.byType(BookEditDialog), findsNothing);
  });
}
