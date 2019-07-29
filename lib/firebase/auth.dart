import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class _AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Firestore _db = Firestore.instance;
  String userId;

  Future<FirebaseUser> handleLogin() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user = (await auth.signInWithCredential(credential)).user;
      userId = user.uid;
      updateUserDate(user);
      return user;
    } catch (e) {
      return null;
    }
  }

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

  signOut() {
    auth.signOut();
    _googleSignIn.signOut();
  }

  Future<String> getUserId() async {
    userId = (await auth.currentUser()).uid;
    return userId;
  }
}

final _AuthService authService = _AuthService();
