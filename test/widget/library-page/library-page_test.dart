import 'package:dima2018_colombo_troianiello/interfaces/base-auth.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-library.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/confirm-dialog.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/book-list-row.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/library-page.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/move-book-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mockito/mockito.dart';

class MockLibrary extends Mock implements BaseLibrary {}

class MockAuth extends Mock implements BaseAuth {}

void main() {
  List<Book> _books = [
    Book(
      description: "ok",
      edition: "fst",
      image: "",
      isbn: "1234567890123",
      publisher: "me",
      title: "B1",
    ),
    Book(
      description: "ok",
      edition: "fst",
      image: "",
      isbn: "1234567890124",
      publisher: "me",
      title: "B2",
    ),
  ];

  testWidgets("Test library page", (WidgetTester tester) async {
    MockLibrary library = MockLibrary();
    MockAuth auth = MockAuth();

    when(auth.getUserId()).thenAnswer((_) => "1");
    when(library.getUserLibraries("lib1", "1")).thenAnswer((_) async =>
        [Library(bookCount: 0, name: "Lib2", id: "lib2", image: null)]);

    Widget w = LibProvider(
      library: library,
      book: null,
      auth: auth,
      scanner: null,
      picker: null,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Builder(
          builder: (context) => LibraryPage(
            context: context,
            library: Library(
                bookCount: 3,
                id: "lib1",
                image: null,
                isFavourite: false,
                name: "Lib1"),
          ),
        ),
      ),
    );

    when(library.getBooksStream(any)).thenAnswer((_) async* {
      yield _books;
    });

    await tester.pumpWidget(w);
    await tester.pump();
    expect(find.byType(FloatingActionButton), findsOneWidget);
    await tester.pump();
    expect(find.byType(BookListRow), findsNWidgets(2));
    expect(find.text("Lib1"), findsOneWidget);

    await tester.longPress(find.text("B1"));
    await tester.pump();
    expect(find.text("Lib1"), findsNothing);
    expect(find.text("1"), findsOneWidget);
    await tester.tap(find.byIcon(Icons.select_all));
    await tester.pump();
    expect(find.text("2"), findsOneWidget);
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();
    expect(find.text("Lib1"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.sort));
    await tester.pump();
    await tester.tap(find.byType(SimpleDialogOption).at(1));
    await tester.pump();

    expect(
        (find.byType(Text).at(0).evaluate().single.widget as Text).data, "B2");

    await tester.longPress(find.text("B2"));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.delete_sweep));
    await tester.pump();
    expect(find.byType(ConfirmDialog), findsOneWidget);
    await tester.tap(find.text("YES"));
    verify(library.deleteBooksFromLibrary(any, "lib1")).called(1);

    await tester.longPress(find.text("B2"));
    await tester.pump();
    await tester.tap(find.byIcon(MdiIcons.arrowRightBold));
    await tester.pump();
    expect(find.byType(MoveBookDialog), findsOneWidget);
    await tester.pump();
    expect(find.byType(SimpleDialogOption), findsOneWidget);
    await tester.tap(find.text("Lib2"));
    await tester.pump();
    expect(find.text("Lib1"), findsOneWidget);

    await tester.longPress(find.text("B1"));
    await tester.pump();
    await tester.tap(find.text("B1"));
    await tester.pump();
    expect(find.text("Lib1"), findsOneWidget);
  });
}
