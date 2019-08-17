import './review-widget.dart';
import 'package:dima2018_colombo_troianiello/library-provider.dart';
import 'package:flutter/material.dart';
import '../../../model/review.model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../common/localization.dart';

///Shows the review of the user
///
///Retrieves the review from Firestore and creates a widget, that
///allows to read and edit it.
class UserReviewSection extends StatelessWidget {
  ///The identifier of the book.
  final String isbn;

  ///Constructor of UserReviewSection.
  ///
  ///[isbn] is required and is the identifier of the book.
  UserReviewSection({
    @required this.isbn,
  });

  //Retreives the [Review] from Firestore
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: LibProvider.of(context)
            .book
            .getUserReview(isbn, LibProvider.of(context).auth.getUserId()),
        builder: (BuildContext context, AsyncSnapshot<Review> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
                child: CircularProgressIndicator(),
              ),
            );
          else {
            return _UserReviewSection(
              review: snapshot.data,
              isbn: isbn,
            );
          }
        });
  }
}

///Shows the [Review] of the user.
///
///Retrieves the [Review] from Firestore and creates a widget, that
///allows to read and edit it.
class _UserReviewSection extends StatefulWidget {
  ///The identifier of book.
  final String isbn;

  ///The review of the user.
  final Review review;

  ///Constructor of _UserReviewSection.
  ///
  ///[review] and [isbn] are required.
  ///[review] is the review wrote by the user and [isbn] is the identifier of book.
  _UserReviewSection({
    @required this.review,
    @required this.isbn,
  });

  //Creates the state of _UserReviewSection.
  @override
  _UserReviewSectionState createState() => new _UserReviewSectionState();
}

///The state of _UserReviewSection.
class _UserReviewSectionState extends State<_UserReviewSection> {
  ///The shown [Review].
  Review _review;

  ///Indicates if this [_review] is going to be edit.
  ///
  ///If [_isModifyMode] is true, the widget shown a [TextFormField],
  ///that allows to edit this [_review].
  bool _isModifyMode;

  ///Indicates if [User] wrote this [_review] in the past.
  ///
  ///If [_isModifyMode] is true, the [_review] does not exists and
  ///the widget shown a [TextFormField], that allows to edit this [_review].
  bool _isNotInitialMode;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  //Initializes [_isNotInitialMode] and [_isModifyMode].
  @override
  void initState() {
    super.initState();
    _review = widget.review;
    _isNotInitialMode = false;
    _isModifyMode = false;
  }

  //If [_isNotInitialMode] is true, shows a button controlled by [_isModifyMode].
  @override
  Widget build(BuildContext context) {
    if (_review.isEmpty())
      _isNotInitialMode = false;
    else {
      _isNotInitialMode = true;
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Localization.of(context).review,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              if (_isNotInitialMode)
                _isModifyMode
                    ? IconButton(
                        padding: const EdgeInsets.all(0.0),
                        icon: Icon(Icons.close),
                        onPressed: () => setState(() => _isModifyMode = false),
                      )
                    : IconButton(
                        padding: const EdgeInsets.all(0.0),
                        icon: Icon(Icons.edit),
                        onPressed: () => setState(() => _isModifyMode = true),
                      ),
            ],
          ),
        ),
        if (!_isNotInitialMode)
          _buildForm(context)
        else if (_isModifyMode)
          _buildForm(context)
        else
          _buildReview(context),
      ],
    );
  }

  ///Builds a widget, that shows [_review].
  ///
  ///This widget contains a [FlutterRatingBar], that shows the score given by the [User],
  ///and a [Text], that shows user's comment.
  Widget _buildReview(BuildContext context) {
    return ReviewWidget(
      review: _review,
      color: Color.fromRGBO(140, 0, 50, 1),
    );
  }

  ///Builds a widget, that allows to edit this [_review].
  ///
  ///This widget contains a [FlutterRatingBar], that control the score of [_review],
  ///and a [TextFormField], in which the user's comment is wrote.
  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          FlutterRatingBar(
            allowHalfRating: false,
            onRatingUpdate: (v) {
              setState(() {
                _review.score = v.toInt();
              });
            },
            itemCount: 5,
            initialRating: _review.score.toDouble(),
            fillColor: Colors.grey,
            borderColor: Colors.grey,
            itemSize: 30.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: TextFormField(
              maxLines: 5,
              maxLength: 300,
              initialValue: _review.isEmpty() ? "" : _review.text,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: Localization.of(context).hintReview,
              ),
              onSaved: (text) => _review.text = text,
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
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Review newReview = await LibProvider.of(context)
                      .book
                      .saveReview(_review, widget.isbn,
                          LibProvider.of(context).auth.getUser());
                  _isModifyMode = false;
                  setState(() => _review = newReview);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
