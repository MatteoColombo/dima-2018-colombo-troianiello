import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/review.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/reviews-page/other-reviews.dart';
import 'package:dima2018_colombo_troianiello/view/book/reviews-page/review-widget.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test list reviews and filters", (WidgetTester tester) async {
    
    //The reviews to display
    Review r1 = new Review();
    r1.score = 2;
    r1.text = 'primo';
    r1.date = DateTime(1970, 12, 20);
    r1.user = 'ST';
    r1.userId = '2';
    Review r2 = new Review();
    r2.text = 'prova';
    r2.date = DateTime(1970, 12, 20);
    r2.user = 'TT';
    r2.userId = '1';
    var reviews = [r1, r2];
    final Widget widget = LibProvider(
      auth: null,
      book: null,
      library: null,
      picker: null,
      scanner: null,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
          body: ReviewsSection(reviews: reviews),
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();

    //Tests if the all reviews are displayed
    expect(find.byType(ReviewWidget), findsNWidgets(2));

    //Tests the filter bar
    expect(find.byType(ChoiceChip), findsNWidgets(6));
    expect(find.text(r1.user), findsOneWidget);
    expect(find.text(r2.user), findsOneWidget);

    //Tests the 1 star filter
    await tester.tap(find.text('1'));
    await tester.pump();
    expect(find.byType(ReviewWidget), findsOneWidget);
    expect(find.byType(ChoiceChip), findsNWidgets(6));
    expect(find.text(r1.user), findsNothing);
    expect(find.text(r2.user), findsOneWidget);

    //Tests the 2 stars filter
    await tester.tap(find.text('2'));
    await tester.pump();
    expect(find.byType(ReviewWidget), findsOneWidget);
    expect(find.byType(ChoiceChip), findsNWidgets(6));
    expect(find.text(r1.user), findsOneWidget);
    expect(find.text(r2.user), findsNothing);

    //Tests the 3 stars filter
    await tester.tap(find.text('3'));
    await tester.pump();
    expect(find.byType(ReviewWidget), findsNothing);
    expect(find.byType(ChoiceChip), findsNWidgets(6));
    expect(find.text(r1.user), findsNothing);
    expect(find.text(r2.user), findsNothing);

    //Tests the 4 stars filter
    await tester.tap(find.text('4'));
    await tester.pump();
    expect(find.byType(ReviewWidget), findsNothing);
    expect(find.byType(ChoiceChip), findsNWidgets(6));
    expect(find.text(r1.user), findsNothing);
    expect(find.text(r2.user), findsNothing);

    //Tests the 5 stars filter
    await tester.tap(find.text('5'));
    await tester.pump();
    expect(find.byType(ReviewWidget), findsNothing);
    expect(find.byType(ChoiceChip), findsNWidgets(6));
    expect(find.text(r1.user), findsNothing);
    expect(find.text(r2.user), findsNothing);

    //Tests the All filter
    await tester.tap(find.text('ALL'));
    await tester.pump();
    expect(find.byType(ReviewWidget), findsNWidgets(2));
    expect(find.byType(ChoiceChip), findsNWidgets(6));
    expect(find.text(r1.user), findsOneWidget);
    expect(find.text(r2.user), findsOneWidget);
  });
}
