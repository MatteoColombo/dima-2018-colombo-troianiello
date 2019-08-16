import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/popup-option-enum.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/row-popup-menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  testWidgets("Test a disabled row popup menu", (WidgetTester tester) async {
    Widget w = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: Card(
        child: RowPopUpMenu(
          enabled: false,
          callback: null,
        ),
      ),
    );

    await tester.pumpWidget(w);

    await tester.pump();
    expect(find.byType(PopupMenuButton), findsOneWidget);
    expect(find.byType(PopupMenuEntry), findsNothing);
    await tester.tap(find.byType(PopupMenuButton));

    await tester.pump();
    expect(find.byType(PopupMenuButton), findsOneWidget);
    expect(find.byType(PopupMenuEntry), findsNothing);
  });

  testWidgets("Test an enabled row popup menu", (WidgetTester tester) async {
    Widget w = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: Card(
        child: RowPopUpMenu(
          enabled: true,
          callback: (p1, p2) => print("hello"),
        ),
      ),
    );

    await tester.pumpWidget(w);

    await tester.pump();
    expect(find.byType(PopupMenuButton), findsOneWidget);
    expect(find.byType(PopupMenuItem), findsNothing);
    await tester.tap(find.byType(PopupMenuButton));

    await tester.pump();
    expect(find.byType(PopupMenuButton), findsOneWidget);
    expect(find.byType(PopupMenuItem), findsNWidgets(2));
  });
}
