import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/review.model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
///Shows the review of a generic user.
class ReviewWidget extends StatelessWidget {
  ///The [Review] to show.
  final Review review;
  ///The backgound color of the user informations section.
  final Color color;

  ///Constructor of ReviewWidget.
  ///
  ///[review] and [color] are required.
  ///[review] is the [Review] to show.
  ///[color] is the backgound color of the user informations section.
  ReviewWidget({
    @required this.review,
    @required this.color,
  });

  ///Builds a widget, that shows [review].
  ///
  ///This widget contains a [FlutterRatingBar], that shows the score given by the [User], 
  ///and a [Text], that shows user's comment.
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(0.0),
            leading: Stack(
              children: [
                CircleAvatar(
                  child: Text(
                    review.user,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: color,
                  radius: 25,
                ),
              ],
            ),
            title: FlutterRatingBar(
              allowHalfRating: false,
              itemCount: 5,
              initialRating: review.score.toDouble(),
              fillColor: Colors.grey,
              borderColor: Colors.grey,
              itemSize: 15.0,
              ignoreGestures: true,
              onRatingUpdate: (v) {},
            ),
            subtitle: Text(DateFormat(' d MMMM y').format(review.date)),
          ),
          if (review.text.length != 0)
            Text(
              '"' + review.text + '"',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16.0,
              ),
            ),
        ],
      ),
    );
  }
}
