import 'package:dima2018_colombo_troianiello/view/library-editor/image-buttons-enum.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/image-buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test the image widget buttons when there is no image", (WidgetTester tester) async {
    ImgBtnEnum choice;
    bool hasImage = false;
    final Widget w = MaterialApp(
      home: Scaffold(
        body: Container(
          width: 500,
          height: 500,
          child: Stack(
            children: <Widget>[
              ImageButtons(
                callback: (val) => choice = val,
                hasImage: hasImage,
              )
            ],
          ),
        ),
      ),
    );
    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(IconButton), findsNWidgets(2));

    await tester.tap(find.byType(IconButton).first);
    await tester.pump();
    expect(choice, ImgBtnEnum.Upload);
    await tester.tap(find.byType(IconButton).at(1));
    await tester.pump();
    expect(choice, ImgBtnEnum.Photo);
  });

    testWidgets("Test the image widget buttons when there is an image", (WidgetTester tester) async {
    ImgBtnEnum choice;
    bool hasImage = true;
    final Widget w = MaterialApp(
      home: Scaffold(
        body: Container(
          width: 500,
          height: 500,
          child: Stack(
            children: <Widget>[
              ImageButtons(
                callback: (val) => choice = val,
                hasImage: hasImage,
              )
            ],
          ),
        ),
      ),
    );
    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(IconButton), findsNWidgets(3));

    await tester.tap(find.byType(IconButton).first);
    await tester.pump();
    expect(choice, ImgBtnEnum.Delete);
  });
}
