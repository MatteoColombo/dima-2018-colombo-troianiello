import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String user;
  String text;
  int score;
  DateTime date;

  Review() {
    user = "";
    text = "";
    score = 1;
    date = null;
  }

  assimilate(DocumentSnapshot snap) {
    user = snap['user'];
    text = snap['text'];
    score = snap['score'];
    date = snap['date'].toDate();
  }
}
