import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './auth.dart';
import './login.dart';
import './splash.dart';
import './view/library/library-list.dart';
import 'mainactivity.dart';

void main() => runApp(BookPage());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue[700],
        accentColor: Colors.yellow,
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
          if (snapshot.hasData) {
            return LibraryList();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
