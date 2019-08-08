import 'package:dima2018_colombo_troianiello/interfaces/base-auth.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-book.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-library.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-picker.dart';
import 'package:dima2018_colombo_troianiello/interfaces/base-scanner.dart';
import 'package:flutter/widgets.dart';

class FireProvider extends InheritedWidget {
  const FireProvider({
    Key key,
    @required this.auth,
    @required this.book,
    @required this.library,
    @required this.child,
    @required this.scanner,
    @required this.picker,
  }) : super(key: key);

  final BaseAuth auth;
  final BaseBook book;
  final BaseLibrary library;
  final BasePicker picker;
  final BaseScanner scanner;
  final Widget child;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static FireProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(FireProvider);
  }
}
