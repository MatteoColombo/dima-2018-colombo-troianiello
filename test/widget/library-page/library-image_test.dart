import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/lbrary-image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test with null image", (WidgetTester tester) async {
    final Widget w = LibraryImage(
      image: null,
      width: 400,
      tag: "tag",
    );

    await tester.pumpWidget(w);
    await tester.pump();

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsNothing);
  });

  testWidgets("Test with null image", (WidgetTester tester) async {
    final Widget w = LibraryImage(
      image: "",
      width: 400,
      tag: "tag",
    );

    await tester.pumpWidget(w);
    await tester.pump();

    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });
}
