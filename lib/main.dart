import 'package:dima2018_colombo_troianiello/view/home/home.dart';
import 'package:dima2018_colombo_troianiello/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './view/common/localization.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './firebase/auth.dart';
import './login.dart';

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
