import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/favourite-checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test the favourite checkbox", (WidgetTester tester) async {
    bool fav = false;

    final Widget w = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: Card(
        child: FavouriteCheckbox(
          favourite: fav,
          onChange: (val) => fav = val,
        ),
      ),
    );
    await tester.pumpWidget(w);
    await tester.pump();
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(fav, true);
  });
}
