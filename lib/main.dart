import 'package:flutter_localizations/flutter_localizations.dart';
import './view/common/localization.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './firebase/auth.dart';
import './login.dart';
import 'main-activity.dart';

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
      title: 'Flutter Demo',
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
      stream: authService.auth.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return MainActivity();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
