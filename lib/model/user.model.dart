import 'package:firebase_auth/firebase_auth.dart';

class User {
  User({this.id, this.email, this.imgUrl, this.name, this.initials});

  String id;
  String name;
  String email;
  String imgUrl;
  String initials;

  assimilate(FirebaseUser fbUser) {
    id = fbUser.uid;
    name = fbUser.displayName;
    email = fbUser.email;
    imgUrl = fbUser.photoUrl;
    initials = name.split(" ").first.substring(0, 1).toUpperCase() +
        name.split(" ").last.substring(0, 1).toUpperCase();
  }
}
