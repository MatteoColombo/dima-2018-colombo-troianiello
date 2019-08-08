import 'package:dima2018_colombo_troianiello/view/home/home.dart';
import 'package:dima2018_colombo_troianiello/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './view/common/localization.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './firebase/auth.dart';
import './login.dart';

/// The entry point of the application.
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    return StreamBuilder<FirebaseUser>(
      stream: authService.getAuthStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return Home();
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
