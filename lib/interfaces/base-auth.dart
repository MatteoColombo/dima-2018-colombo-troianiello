import 'package:dima2018_colombo_troianiello/model/user.model.dart';

abstract class BaseAuth {
  Future<User> login();
  Future<void> logout();
  Stream<User> getAuthStateChange();
  String getUserId();
  String getUserName();
  User getUser();
}
