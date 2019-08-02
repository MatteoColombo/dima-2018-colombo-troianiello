import 'package:flutter/material.dart';
import './other-reviews.dart';
import './user-review.dart';

class ReviewsWidget extends StatelessWidget {
  final String isbn;
  final bool addBook;

  ReviewsWidget({@required this.isbn, @required this.addBook});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: <Widget>[
        UserReviewSection(
          isbn: isbn,
          addBook: addBook,
        ),
        ReviewsSection(
          isbn: isbn,
        ),
      ],
    );
  }
}
