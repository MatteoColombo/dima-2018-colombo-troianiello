import 'package:flutter/material.dart';
import './firebase/auth.dart';

class MainActivity extends StatelessWidget {
  MainActivity(this._userName);
  final String _userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dima 2018"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Benvenuto, $_userName",
            ),
            MaterialButton(
              child: Text("Sign out"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => authService.signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
