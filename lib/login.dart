import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';

/// Shows the login page of the application.
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
                      "assets/images/google.png",
                      width: 38,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      Localization.of(context).loginWithGoogle,
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              onPressed: () => LibProvider.of(context).auth.login(),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
