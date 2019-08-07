import 'package:dima2018_colombo_troianiello/view/common/confirm-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test confirmation dialog", (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: ConfirmDialog(question: "are you sure"),
    );

    await tester.pumpWidget(widget);

    await tester.idle();

    await tester.pump();

    expect(find.text("are you sure"), findsOneWidget);
    expect(find.byType(FlatButton), findsNWidgets(2));
  });
}
