import 'package:dima2018_colombo_troianiello/view/common/loading-spinner.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test loading spinner widget", (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: Card(child: LoadingSpinner("msg")),
    );

    await tester.pumpWidget(widget);

    await tester.idle();

    await tester.pump();

    expect(find.text("msg"), findsOneWidget);
    expect(find.text("Please wait..."),findsOneWidget);
  });
}
