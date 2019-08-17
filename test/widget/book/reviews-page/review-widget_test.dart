import 'package:dima2018_colombo_troianiello/model/review.model.dart';
import 'package:dima2018_colombo_troianiello/view/book/reviews-page/review-widget.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets("Test review widget", (WidgetTester tester) async {
    final Review r = new Review();

    //The review to display
    r.date = DateTime(1970, 12, 20);
    r.score = 2;
    r.text = "text";
    r.user='TT';
    r.userId='0';
    final Widget widget = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: Scaffold(
        body: ReviewWidget(review: r, color: Colors.red),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();

    //Tests if the initials are right
    expect(find.text(r.user), findsOneWidget);

    //Tests if the date is right
    expect(find.text(' 20 December 1970'), findsOneWidget);
    
  //Tests if the text is right
    expect(find.text('"'+r.text+'"'), findsOneWidget);
  });
}
