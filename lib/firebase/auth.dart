import 'package:dima2018_colombo_troianiello/interfaces/base-auth.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Service used to communicate with Firebase and to manage the user authentication.
class Auth extends BaseAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Firestore _db = Firestore.instance;
  User _user;

  /// Handles the user login.
  ///
  /// When the user logs in, its information are stored so that they can be retrieved faster.
  Future<User> login() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      _user = new User();
      _user.assimilate(user);

      _updateUserData(user);
      return _user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Stream that listens to changes on the authentication state and yields a new user every time it changes.
  @override
  Stream<User> getAuthStateChange() async* {
    Stream<FirebaseUser> user = _auth.onAuthStateChanged;
    await for (FirebaseUser u in user) {
      if (u != null) {
        _user = new User();
        _user.assimilate(u);
      }else {
        _user=null;
      }
      yield _user;
    }
  }

  /// Method used to update user data in the Cloud Firestore database.
  void _updateUserData(FirebaseUser user) async {
    DocumentReference docRef = _db.collection('users').document(user.uid);
    return docRef.setData({
      'uid': user.uid,
      'name': user.displayName,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'lastLogin': DateTime.now()
    }, merge: true);
  }

  /// Method used to sign out from the application.
  @override
  Future<void> logout() async {
    _auth.signOut();
    _googleSignIn.signOut();
  }

  /// Returns the user ID.
  String getUserId() => _user.id;

  /// Returns the user name.
  String getUserName() => _user.name;

  /// Returns a FirebaseUser representing the user.
  User getUser() => _user;
}
