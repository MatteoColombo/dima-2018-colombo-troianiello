import 'package:dima2018_colombo_troianiello/interfaces/base-auth.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/home/home-appbar.dart';
import 'package:dima2018_colombo_troianiello/view/home/home-drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements BaseAuth {}

void main() {
  testWidgets("Test the home drawer", (WidgetTester tester) async {
    final User user = User(
        email: "fakemail",
        id: "1",
        imgUrl: "",
        initials: "NC",
        name: "Nome Cognome");
    final MockAuth auth = MockAuth();
    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

    final Widget w = LibProvider(
      auth: auth,
      book: null,
      library: null,
      picker: null,
      scanner: null,
      child: MaterialApp(
        localizationsDelegates: [LocalizationDelegate()],
        home: Scaffold(
          key: key,
          appBar: HomeAppbar(),
          drawer: HomeDrawer(
            user: user,
          ),
        ),
      ),
    );

    when(auth.logout()).thenAnswer((_) async => true);

    await tester.pumpWidget(w);
    await tester.pump();
    key.currentState.openDrawer();
    await tester.pump();
    expect(find.byType(Drawer), findsOneWidget);
    expect(find.text("Nome Cognome"), findsOneWidget);
    expect(find.text("fakemail"), findsOneWidget);
    expect(find.text("Settings"), findsOneWidget);
    expect(find.text("Log out"), findsOneWidget);
    await tester.tap(find.text("Log out"));
  });
}
