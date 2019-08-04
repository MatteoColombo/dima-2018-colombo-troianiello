import '../../../firebase/book-repo.dart';
import '../../../model/review.model.dart';
import 'package:flutter/material.dart';
import './other-reviews.dart';
import './user-review.dart';

class ReviewsWidget extends StatelessWidget {
  final String isbn;

  ReviewsWidget({@required this.isbn});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserReviewSection(
          isbn: isbn,
        ),
        FutureBuilder(
          future: bookManager.getOtherReviews(isbn),
          builder:
              (BuildContext context, AsyncSnapshot<List<Review>> snapshot) {
            if (!snapshot.hasData)
              return Container();
            else
              return ReviewsSection(
                reviews: snapshot.data,
              );
          },
        ),
      ],
    );
  }
}
