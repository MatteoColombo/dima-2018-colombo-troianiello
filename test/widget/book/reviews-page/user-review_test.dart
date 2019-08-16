import 'package:dima2018_colombo_troianiello/interfaces/base-auth.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/review.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/reviews-page/review-widget.dart';
import 'package:dima2018_colombo_troianiello/view/book/reviews-page/user-review.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBook extends Mock implements BaseBook {}
class MockAuth extends Mock implements BaseAuth {}
final BaseBook book= new MockBook();
final BaseAuth auth= new MockAuth();

void main() {

  //Verifies the intial mode of the widget
  testWidgets("Test initial review", (WidgetTester tester) async {

    //Creates the review to display
    Review r=new Review();
    Review r2=new Review();
    r2.text='prova';
    r2.date=DateTime(1970,12,20);
    r2.user='TT';
    r2.userId='0';
    var reviews=[r,r2];
    final Widget widget = LibProvider(
      auth: auth,
      book: book,
      library: null,
      picker: null,
      scanner: null,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
          body: UserReviewSection(isbn:'000'),
        ),
      ),
    );

    //Sets up the mocks
    when(book.getUserReview(any,any))
        .thenAnswer((_) => Future.value(reviews.removeAt(0)));
    when(auth.getUserId())
        .thenAnswer((_) => '0');
    
    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();

    //Seconds pump for the FutureBuilder
    await tester.pump();

    //Verifies the form is displayed
    expect(find.byType(ReviewWidget), findsNothing);
    expect(find.byType(Form), findsOneWidget);
    expect(find.text('PUBLISH'),findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.edit), findsNothing);
    expect(find.widgetWithIcon(IconButton, Icons.close), findsNothing);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text("Write a review (optional)"), findsOneWidget);

    //Inserts a review
    await tester.enterText(find.byType(TextFormField), 'prova');
    await tester.tap(find.text('PUBLISH'));

    //Controls the review
    Review review = verify(book.saveReview(captureAny,any,any)).captured.first;
    expect(review.text, 'prova');
    expect(review.score, 1);
  });

  //Tests the not initial mode
  testWidgets("Test review not empty", (WidgetTester tester) async {

    //Creates the review to display
    Review r=new Review();
    r.text='prova';
    r.date=DateTime(1970,12,20);
    r.user='TT';
    r.userId='0';
    final Widget widget = LibProvider(
      auth: auth,
      book: book,
      library: null,
      picker: null,
      scanner: null,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
          body: UserReviewSection(isbn:'000'),
        ),
      ),
    );

    //Sets up the mocks
    when(book.getUserReview(any,any))
        .thenAnswer((_) => Future.value(r));
    when(auth.getUserId())
        .thenAnswer((_) => '0');
    
    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();

    //Second pump for the FutureBuilder
    await tester.pump();

    //Verifies the review is displayed
    expect(find.byType(ReviewWidget), findsOneWidget);
    expect(find.byType(Form), findsNothing);
    expect(find.text(r.user),findsOneWidget);
    expect(find.text('"'+r.text+'"'),findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.edit), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.close), findsNothing);

    //Changes the review with the form
    await tester.tap(find.widgetWithIcon(IconButton, Icons.edit));
    await tester.pump();

    //Verifies the form is displayed
    expect(find.byType(ReviewWidget), findsNothing);
    expect(find.byType(Form), findsOneWidget);
    expect(find.text(r.user),findsNothing);
    expect(find.text(r.text),findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.edit), findsNothing);
    expect(find.widgetWithIcon(IconButton, Icons.close), findsOneWidget);
    
  });
}
