import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/name-text-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test the library name text editor", (WidgetTester tester) async {
    TextEditingController controller = TextEditingController(text: "");
    Widget w = MaterialApp(
      home: Card(
        child: NameTextField(
          controller: controller,
        ),
      ),
      localizationsDelegates: [LocalizationDelegate()],
    );

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(TextField), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, "ciao");
    await tester.pump();

    expect(controller.text, "ciao");
  });
}
