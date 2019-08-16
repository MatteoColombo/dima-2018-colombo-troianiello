import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/sort-books-enum.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/sort-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test the sorting widget", (WidgetTester tester) async {
    final Widget w = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: SortDialog(
        sort: SortMethods.Oldest,
      ),
    );

    await tester.pumpWidget(w);
    await tester.pump();

    expect(find.byType(SimpleDialogOption), findsNWidgets(4));
    expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    expect(find.byIcon(Icons.radio_button_unchecked), findsNWidgets(3));
  });
}
