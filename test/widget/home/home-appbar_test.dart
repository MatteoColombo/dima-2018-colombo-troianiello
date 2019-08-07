import 'package:dima2018_colombo_troianiello/view/home/home-appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test appbar in normal conditions", (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      home: Scaffold(
        appBar: HomeAppbar(),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.text("NonSoloLibri"), findsOneWidget);
  });

  testWidgets("Test appbar in selecting mode", (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      home: Scaffold(
        appBar: HomeAppbar(
          selecting: true,
          selectedCount: 5,
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    expect(find.byType(IconButton), findsNWidgets(3));
    expect(find.text("5"), findsOneWidget);
  });

  testWidgets("Test appbar in search mode", (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      home: Scaffold(
        appBar: HomeAppbar(
          searchController: TextEditingController(text: "ciao"),
          searching: true,
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
