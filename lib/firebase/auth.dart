import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Service used to communicate with Firebase and to manage the user authentication.
class _AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Firestore _db = Firestore.instance;
  FirebaseUser _user;

  /// Handles the user login.
  ///
  /// When the user logs in, its information are stored so that they can be retrieved faster.
  Future<FirebaseUser> handleLogin() async {
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
      _user = user;
      updateUserDate(user);
      return user;
    } catch (e) {
      return null;
    }
  }

  /// Stream that listens to changes on the authentication state and yields a new user every time it changes.
  Stream<FirebaseUser> getAuthStateChanges() async* {
    Stream<FirebaseUser> user = _auth.onAuthStateChanged;
    await for (FirebaseUser u in user) {
      if (u != null) {
        _user = u;
      }
      yield u;
    }
  }

  /// Method used to update user data in the Cloud Firestore database.
  void updateUserDate(FirebaseUser user) async {
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
  signOut() {
    _auth.signOut();
    _googleSignIn.signOut();
  }

  /// Returns the user ID.
  String getUserId() => _user.uid;

  /// Returns the user name.
  String getUserName() => _user.displayName;

  /// Returns a FirebaseUser representing the user.
  FirebaseUser getUser() => _user;
}

final _AuthService authService = _AuthService();
