import 'dart:io';

import 'package:dima2018_colombo_troianiello/interfaces/base-auth.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-library.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-picker.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/loading-spinner.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/edit-library.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/favourite-checkbox.dart';
import 'package:dima2018_colombo_troianiello/view/library-editor/new-library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements BaseAuth {}

class MockLibrary extends Mock implements BaseLibrary {}

class MockPicker extends Mock implements BasePicker {}

void main() {
  testWidgets("Test the edit library widget", (WidgetTester tester) async {
    Library l = Library(
      id: "lib1",
      name: "Lib 1",
      image: null,
      isFavourite: false,
    );
    MockAuth auth = MockAuth();
    MockLibrary library = MockLibrary();
    MockPicker picker = MockPicker();

    Widget w = LibProvider(
      auth: auth,
      book: null,
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: FlatButton(
                child: Text("open dialog"),
                onPressed: () => showDialog(
                    context: context, builder: (context) => NewLibrary()),
              ),
            ),
          ),
        ),
        localizationsDelegates: [LocalizationDelegate()],
      ),
      library: library,
      picker: picker,
      scanner: null,
    );

    await tester.pumpWidget(w);
    await tester.pump();
    await tester.tap(find.text("open dialog"));
    await tester.pump();
    expect(find.byType(NewLibrary), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    await tester.tap(find.byType(FavouriteCheckbox));
    await tester.pump();
    await tester.enterText(find.byType(TextField).first, "ciao");
    await tester.pump();

    when(picker.getImage(any, any, any))
        .thenAnswer((_) async => File("assets/images/google.png"));

    await tester.tap(find.byIcon(Icons.camera_alt));
    await tester.pump();
    expect(find.byType(IconButton), findsNWidgets(3));

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();
    expect(find.byType(IconButton), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.file_upload));
    await tester.pump();
    expect(find.byType(IconButton), findsNWidgets(3));

    verify(picker.getImage(any, any, any)).called(2);

    when(library.uploadFile(any, any)).thenAnswer((_) async => "fakeurl");
    when(library.saveLibrary(any, any)).thenAnswer((_) async => true);

    await tester.tap(find.text("SAVE"));

    await tester.pump();
    expect(find.byType(Dialog), findsNothing);
    expect(find.byType(LoadingSpinner), findsNothing);

    verify(library.uploadFile(any, any)).called(1);
    verify(library.saveLibrary(any, any)).called(1);
  });
}
