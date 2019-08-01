import 'package:dima2018_colombo_troianiello/firebase/auth.dart';
import 'package:flutter/material.dart';
import '../../../firebase/book-repo.dart';
import '../../../model/review.model.dart';
import './other-reviews.dart';
import './user-review.dart';

class ReviewsWidget extends StatelessWidget {
  final String isbn;
  final bool addBook;

  ReviewsWidget({@required this.isbn, @required this.addBook});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            /*NewReviewSection(
              isbn: isbn,
              addBook: addBook,
            ),*/
            ReviewsSection(
              isbn: isbn,
            ),
          ],
        ),
      ],
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bookManager.getReviews(isbn),
      builder: (BuildContext context, AsyncSnapshot<List<Review>> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
              child: CircularProgressIndicator(),
            ),
          );
        else {
          Review review= awaitsnapshot.data.where((Review review) async{
            return 1 == review.userId.compareTo(await authService.getUserId());
          }).toList().first;
          return ListView(children: <Widget>[
            UserReviewSection(review: ,),
          ],);
          //return _buildReviews(snapshot.data.where(_functionSelected).toList());
        }
      },
    );
  }*/
}