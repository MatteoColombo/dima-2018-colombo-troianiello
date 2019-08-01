import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/review.model.dart';
import '../../../firebase/book-repo.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../common/localization.dart';

class UserReviewSection extends StatefulWidget {
  final String isbn;
  final bool addBook;
  final Review review;
  UserReviewSection({
    @required this.isbn,
    @required this.addBook,
    @required this.review,
  });

  @override
  _UserReviewSectionState createState() => new _UserReviewSectionState();
}

class _UserReviewSectionState extends State<UserReviewSection> {
  Review newReview;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    newReview = Review();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              Localization.of(context).reviews,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          FlutterRatingBar(
            allowHalfRating: false,
            onRatingUpdate: (v) {
              setState(() {
                newReview.score = v.toInt();
              });
            },
            itemCount: 5,
            initialRating: newReview.score.toDouble(),
            fillColor: Colors.grey,
            borderColor: Colors.grey,
            itemSize: 30.0,
          ),
          ListTile(
            title: TextFormField(
              maxLines: 5,
              maxLength: 300,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: Localization.of(context).hintReview,
              ),
              validator: (text) {
                if (text.length == 0)
                  return Localization.of(context).fieldError;
                else
                  return null;
              },
              onSaved: (text) => newReview.text = text,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              child: Text(
                Localization.of(context).publish.toUpperCase(),
                style: TextStyle(
                  color: Color.fromRGBO(140, 0, 50, 1),
                  fontSize: 17.0,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate() && !widget.addBook) {
                  _formKey.currentState.save();
                  bookManager.saveReview(newReview, widget.isbn);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
