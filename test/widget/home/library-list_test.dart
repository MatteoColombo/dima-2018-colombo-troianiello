import 'dart:math';

import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/home/library-list-row.dart';
import 'package:dima2018_colombo_troianiello/view/home/library-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test library list with null libraries",
      (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: LibraryList(
        selected: [],
        onSelect: null,
        libraries: null,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Test library zero libraries", (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: LibraryList(
        selected: [],
        onSelect: null,
        libraries: [],
      ),
    );

    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(LibraryListRow), findsNothing);
  });

  testWidgets("Test library zero libraries", (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: LibraryList(
        selected: [],
        onSelect: null,
        libraries: [
          Library(
              bookCount: 3,
              id: "fake",
              image: null,
              isFavourite: false,
              name: "Fake Library")
        ],
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    print(widget);
    expect(find.byType(LibraryListRow), findsOneWidget);
  });
}
