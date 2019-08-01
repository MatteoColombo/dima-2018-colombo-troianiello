import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String user;
  String userId;
  String text;
  int score;
  DateTime date;

  Review() {
    userId = "";
    user = "";
    text = "";
    score = 1;
    date = null;
  }

  assimilate(DocumentSnapshot snap) {
    user = snap['user'];
    userId = snap['userId'];
    text = snap['text'];
    score = snap['score'];
    date = snap['date'].toDate();
  }
}
