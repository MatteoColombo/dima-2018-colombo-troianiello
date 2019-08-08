import 'package:flutter/material.dart';

/// Splash screen displayed when the main page is loading.
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
