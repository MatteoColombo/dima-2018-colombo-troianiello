import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/image-background.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test the library editor with null image",
      (WidgetTester tester) async {
    Widget w = ImageBackground();

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets("Test the library editor with a file image",
      (WidgetTester tester) async {
    File f = File("assets/images/google.png");
    Widget w = ImageBackground(
      fileImage: f,
    );

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(Image), findsOneWidget);
  });

    testWidgets("Test the library editor with a url image",
      (WidgetTester tester) async {
    Widget w = ImageBackground(
      urlImage:"",
    );

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
