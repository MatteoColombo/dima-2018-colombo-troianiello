import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Dima 2018",
        theme: ThemeData(
          primaryColor: Colors.orange[700],
        ),
        home: _handleHomePage());
  }

  Widget _handleHomePage() {
    return null;
  }
}
