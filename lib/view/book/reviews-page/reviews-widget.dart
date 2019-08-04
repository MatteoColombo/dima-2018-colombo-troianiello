import '../../../firebase/book-repo.dart';
import '../../../model/review.model.dart';
import 'package:flutter/material.dart';
import './other-reviews.dart';
import './user-review.dart';

class ReviewsWidget extends StatelessWidget {
  final String isbn;

  ReviewsWidget({@required this.isbn
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: <Widget>[
          UserReviewSection(
            isbn: isbn,
          ),
          FutureBuilder(
      future: bookManager.getOtherReviews(isbn),
      builder: (BuildContext context, AsyncSnapshot<List<Review>> snapshot) {
        if (!snapshot.hasData)
          return Container();
        else
          return ReviewsSection(
            reviews: snapshot.data,
          );
      },
    ),
        ],
      ),
    );
  }
}
