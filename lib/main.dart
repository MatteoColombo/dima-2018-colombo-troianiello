import 'package:dima2018_colombo_troianiello/firebase-provider.dart';
import 'package:dima2018_colombo_troianiello/firebase/book-repo.dart';
import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';
import 'package:dima2018_colombo_troianiello/splash.dart';
import 'package:dima2018_colombo_troianiello/view/home/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './view/common/localization.dart';

import 'package:flutter/material.dart';
import './firebase/auth.dart';
import './login.dart';

/// The entry point of the application.
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FireProvider(
      auth: Auth(),
      book: BookRepo(),
      library: LibraryRepo(),
      picker: null,
      scanner: null,
      child: MaterialApp(
        localizationsDelegates: [
          const LocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('it', ''),
        ],
        title: 'NonSoloLibri',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(140, 0, 50, 1),
          accentColor: Color.fromRGBO(140, 0, 50, 1),
        ),
        home: MainWidgetManager(),
      ),
    );
  }
}

/// The main wdiget of the application.
///
/// Checks the status of the firebase connection and if the user is logged in.
/// If firebase is loading, displays a splash screen.
/// When firebase loaded, depending on the user status shows either the Homepage or the login page.
class MainWidgetManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FireProvider.of(context).auth.getAuthStateChange(),
      builder: (BuildContext context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return Home(context);
          } else {
            return LoginPage();
          }
        } else {
          return Splash();
        }
      },
    );
  }
}
