import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  Review({this.user, this.text, this.date});
  String user;
  String text;
  DateTime date;

  assimilate(DocumentSnapshot snap) {
    user = snap['user'];
    text = snap['review'];
    date = snap['date'].toDate();
  }
}
