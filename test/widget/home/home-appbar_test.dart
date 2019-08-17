import 'package:dima2018_colombo_troianiello/view/common/appbar-buttons-enum.dart';
import 'package:dima2018_colombo_troianiello/view/home/home-appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test appbar in normal conditions", (WidgetTester tester) async {
    AppBarBtn choice;
    final Widget widget = MaterialApp(
      home: Scaffold(
        appBar: HomeAppbar(
          callback: (val, context) => choice = val,
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.text("NonSoloLibri"), findsOneWidget);
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();
    expect(choice, AppBarBtn.Search);
  });

  testWidgets("Test appbar in selecting mode", (WidgetTester tester) async {
    AppBarBtn choice;
    final Widget widget = MaterialApp(
      home: Scaffold(
        appBar: HomeAppbar(
          selecting: true,
          selectedCount: 5,
          callback: (val, context) => choice = val,
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    expect(find.byType(IconButton), findsNWidgets(3));
    expect(find.text("5"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.select_all));
    await tester.pump();
    expect(choice, AppBarBtn.SelectAll);

    await tester.tap(find.byIcon(Icons.delete_sweep));
    await tester.pump();
    expect(choice, AppBarBtn.DeleteAll);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();
    expect(choice, AppBarBtn.Clear);
  });

  testWidgets("Test appbar in search mode", (WidgetTester tester) async {
    AppBarBtn choice;
    final Widget widget = MaterialApp(
      home: Scaffold(
        appBar: HomeAppbar(
          searchController: TextEditingController(text: "ciao"),
          searching: true,
          callback: (val, context) => choice = val,
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();
    expect(choice, AppBarBtn.Clear);
  });
}
