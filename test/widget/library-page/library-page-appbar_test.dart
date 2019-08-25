import 'package:dima2018_colombo_troianiello/view/common/appbar-buttons-enum.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/library-page-appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  testWidgets("Test appbar in normal mode", (WidgetTester tester) async {
    AppBarBtn choice;

    Widget w = MaterialApp(
      home: Scaffold(
        appBar: LibraryPageAppbar(
          callback: (val, _) => choice = val,
          selectedCount: 0,
          selecting: false,
          title: "Fake AppBar",
        ),
      ),
    );

    await tester.pumpWidget(w);
    await tester.pump();

    expect(find.text("Fake AppBar"), findsOneWidget);
    expect(find.byIcon(Icons.sort), findsOneWidget);
    await tester.tap(find.byIcon(Icons.sort));
    await tester.pump();

    expect(choice, AppBarBtn.Sort);
  });

  testWidgets("Test appbar in select mode", (WidgetTester tester) async {
    AppBarBtn choice;

    Widget w = MaterialApp(
      home: Scaffold(
        appBar: LibraryPageAppbar(
          callback: (val, _) => choice = val,
          selectedCount: 3,
          selecting: true,
          title: "Fake AppBar",
        ),
      ),
    );

    await tester.pumpWidget(w);
    await tester.pump();

    expect(find.text("Fake AppBar"), findsNothing);
    expect(find.byType(Icon), findsNWidgets(4));

    await tester.tap(find.byIcon(Icons.delete_sweep));
    await tester.pump();
    expect(choice, AppBarBtn.DeleteAll);

    await tester.tap(find.byIcon(MdiIcons.arrowRightBold));
    await tester.pump();
    expect(choice, AppBarBtn.Move);

    await tester.tap(find.byIcon(Icons.select_all));
    await tester.pump();
    expect(choice, AppBarBtn.SelectAll);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();
    expect(choice, AppBarBtn.Clear);
  });
}
