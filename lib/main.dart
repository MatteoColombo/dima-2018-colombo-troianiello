import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './firebase/auth.dart';
import './login.dart';
import './splash.dart';
import './view/library/library-list.dart';
import './view/addbook/add-book.dart';
import 'mainactivity.dart';
import './view/book/book.dart';

void main() => runApp(MyApp());

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
            return BookPage(
                isbn: '9781401242152'
                    //'9788804711957'
                //'0',
                );
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
