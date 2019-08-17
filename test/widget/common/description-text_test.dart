import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/common/description-text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test description-text", (WidgetTester tester) async {
    final Widget widget = MaterialApp(
      localizationsDelegates: [LocalizationDelegate()],
      home: Card(
        child: DescriptionTextWidget(
            text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Nullam nec elit ac nunc interdum fringilla. Sed semper volutpat felis. '
                'Aliquam sodales, est eget convallis tempus, tortor lorem rhoncus erat, '
                'nec mattis justo urna quis metus. '
                'Nullam et mattis urna, ut tristique tellus. Donec at sem cras amet.'),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.idle();
    await tester.pump();
    
    //Finds 'Show more' button
    expect(find.text('Show more'), findsOneWidget);

    //Tests if the text is displayed in contract mode
    expect(
        find.text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Nullam nec elit ac nunc interdum fringilla. Sed semper volutpat felis. '
            'Aliquam sodales, est e...'),
        findsOneWidget);
    
    expect(find.byType(InkWell), findsOneWidget);

    //Taps 'Show more' button
    await tester.tap(find.text('Show more'));
    await tester.pump();

    //Finds 'Show less' button
    expect(find.text('Show less'), findsOneWidget);

    //Tests if the text is displayed in full mode
    expect(
        find.text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Nullam nec elit ac nunc interdum fringilla. Sed semper volutpat felis. '
            'Aliquam sodales, est eget convallis tempus, tortor lorem rhoncus erat, '
            'nec mattis justo urna quis metus. '
            'Nullam et mattis urna, ut tristique tellus. Donec at sem cras amet.'),
        findsOneWidget);
  });
}
