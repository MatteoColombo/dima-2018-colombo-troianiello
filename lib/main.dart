import 'package:dima2018_colombo_troianiello/camera/barcode-scanner.dart';
import 'package:dima2018_colombo_troianiello/camera/image-picker.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:dima2018_colombo_troianiello/firebase/book-repo.dart';
import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';
import 'package:dima2018_colombo_troianiello/splash.dart';
import 'package:dima2018_colombo_troianiello/view/home/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './view/common/localization.dart';

import 'package:flutter/material.dart';
import './firebase/auth.dart';
import './login.dart';

/// The entry point of the application.
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LibProvider(
      auth: Auth(),
      book: BookRepo(),
      library: LibraryRepo(),
      picker: ImgPicker(),
      scanner: BarcodeScanner(),
      child: MaterialApp(
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
      ),
    );
  }
}

/// The main wdiget of the application.
///
/// Checks the status of the firebase connection and if the user is logged in.
/// If firebase is loading, displays a splash screen.
/// When firebase loaded, depending on the user status shows either the Homepage or the login page.
class MainWidgetManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: LibProvider.of(context).auth.getAuthStateChange(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return Home(context);
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
