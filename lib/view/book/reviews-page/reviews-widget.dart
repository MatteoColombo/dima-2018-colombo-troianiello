import '../../../firebase/book-repo.dart';
import '../../../model/review.model.dart';
import 'package:flutter/material.dart';
import './other-reviews.dart';
import './user-review.dart';

///Shows all reviews of the book.
class ReviewsWidget extends StatelessWidget {
  ///The identifier of the book.
  final String isbn;
  ///Constructor of ReviewsWidget.
  ///
  ///[isbn] is required, which is the identifier of the book..
  ReviewsWidget({@required this.isbn});

  //Cretes the [UserReviewsSection] and the [ReviewsSection].
  //Retreives the [List] of all reviews using a [FutureBuilder].
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
