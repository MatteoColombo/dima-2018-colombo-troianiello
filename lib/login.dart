import 'package:flutter/material.dart';
import './auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: MaterialButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      "images/google.png",
                      width: 38,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Login with Google",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              onPressed: () => authService.handleLogin(),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
