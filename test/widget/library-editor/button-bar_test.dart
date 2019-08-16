import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/save-button-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("test the button bar save button", (WidgetTester tester) async {
    bool called = false;

    TextEditingController controller = TextEditingController(text: "");
    Widget w = MaterialApp(
      home: Builder(
        builder: (context) => Center(
            child: FlatButton(
          child: Text("show dialog"),
          onPressed: () => showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: SaveButtonBar(
                      onSave: () => called = true,
                      textController: controller,
                    ),
                  )),
        )),
      ),
      localizationsDelegates: [LocalizationDelegate()],
    );

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(Dialog), findsNothing);
    await tester.tap(find.text("show dialog"));
    await tester.pump();
    expect(find.byType(Dialog), findsOneWidget);
    await tester.tap(find.text("SAVE"));
    await tester.pump();
    expect(find.byType(Dialog), findsOneWidget);
    expect(called, false);
    controller.text = "ciao";
    await tester.pump();
    await tester.tap(find.text("SAVE"));
    await tester.pump();
    expect(called, false);

    await tester.tap(find.text("CANCEL"));
    await tester.pump();

    expect(find.byType(Dialog), findsNothing);
  });
}
