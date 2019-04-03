import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dima 2018"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                child: Text("Login with Google"),
                onPressed: () => null,
                color: Colors.white,
              ),
              MaterialButton(
                child: Text("Logout"),
                onPressed: () => null,
                color: Colors.red,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
