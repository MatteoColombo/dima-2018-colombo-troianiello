import 'package:dima2018_colombo_troianiello/interfaces/base-auth.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/review.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/reviews-page/other-reviews.dart';
import 'package:dima2018_colombo_troianiello/view/book/reviews-page/review-widget.dart';
import 'package:dima2018_colombo_troianiello/view/book/reviews-page/reviews-widget.dart';
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
  testWidgets("Test reviews widget", (WidgetTester tester) async {

    //The user's empty review
    Review r=new Review();

    //The other reviews
    Review r1=new Review();
    r1.score=2;
    r1.text='primo';
    r1.date=DateTime(1970,12,20);
    r1.user='ST';
    r1.userId='2';
    Review r2=new Review();
    r2.text='prova';
    r2.date=DateTime(1970,12,20);
    r2.user='TT';
    r2.userId='1';
    var reviews=[r1,r2];
    final Widget widget = LibProvider(
      auth: auth,
      book: book,
      library: null,
      picker: null,
      scanner: null,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
          body: ReviewsWidget(isbn:'000'),
        ),
      ),
    );

    //Sets up the mocks
    when(book.getUserReview(any,any))
        .thenAnswer((_) => Future.value(r));
    when(book.getOtherReviews(any,any))
        .thenAnswer((_) => Future.value(reviews));
    when(auth.getUserId())
        .thenAnswer((_) => '0');

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();

    //Second pump for the FutureBuilder
    await tester.pump();

    //Verifies if the list of reviews and the user review are displayed
    expect(find.byType(UserReviewSection), findsOneWidget);
    expect(find.byType(ReviewsSection), findsOneWidget);
    expect(find.byType(ReviewWidget), findsNWidgets(2));
  });

}
