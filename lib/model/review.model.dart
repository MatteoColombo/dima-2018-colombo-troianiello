import 'package:cloud_firestore/cloud_firestore.dart';

///Contains the main informations of a review, made by a user.
class Review {
  ///The person who wrote this review.
  String user;
  ///The identifier of this user.
  String userId;
  ///This user's comment.
  String text;
  ///The rating of this book.
  int score;
  ///The date when this review is wrote.
  DateTime date;

  ///Constructor of Review.
  Review() {
    userId = null;
    user = null;
    text = null;
    score = 1;
    date = null;
  }
  
  ///Fills this review with new informations.
  ///
  ///This review assimilates informations contained in [snap].
  void assimilate(DocumentSnapshot snap) {
    user = snap['user'];
    userId = snap['userId'];
    text = snap['text'];
    score = snap['score'];
    date = snap['date'].toDate();
  }

  ///Indicates that this object is empty.
  bool isEmpty(){
    return this.user==null || this.date==null;
  }
}
