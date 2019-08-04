import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/review.model.dart';
import '../../../firebase/book-repo.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../common/localization.dart';

class UserReviewSection extends StatelessWidget {
  final String isbn;
  UserReviewSection({
    @required this.isbn,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: bookManager.getUserReview(isbn),
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

class _UserReviewSection extends StatefulWidget {
  final String isbn;
  final Review review;
  _UserReviewSection({
    @required this.review,
    @required this.isbn,
  });

  @override
  _UserReviewSectionState createState() => new _UserReviewSectionState();
}

class _UserReviewSectionState extends State<_UserReviewSection> {
  Review review;
  bool isModifyMode;
  bool isNotInitialMode;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    review = widget.review;
    isNotInitialMode = false;
    isModifyMode = false;
  }

  @override
  Widget build(BuildContext context) {
    if (review.isEmpty())
      isNotInitialMode = false;
    else {
      isNotInitialMode = true;
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              if (isNotInitialMode)
                isModifyMode
                    ? IconButton(
                        padding: const EdgeInsets.all(0.0),
                        icon: Icon(Icons.close),
                        onPressed: () => setState(() => isModifyMode = false),
                      )
                    : IconButton(
                        padding: const EdgeInsets.all(0.0),
                        icon: Icon(Icons.edit),
                        onPressed: () => setState(() => isModifyMode = true),
                      ),
            ],
          ),
        ),
        if (!isNotInitialMode)
          _buildForm(context)
        else if (isModifyMode)
          _buildForm(context)
        else
          _buildReview(context),
      ],
    );
  }

  Widget _buildReview(BuildContext context) {
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
                  backgroundColor: Color.fromRGBO(140, 0, 50, 1),
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

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          FlutterRatingBar(
            allowHalfRating: false,
            onRatingUpdate: (v) {
              setState(() {
                review.score = v.toInt();
              });
            },
            itemCount: 5,
            initialRating: review.score.toDouble(),
            fillColor: Colors.grey,
            borderColor: Colors.grey,
            itemSize: 30.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: TextFormField(
              maxLines: 5,
              maxLength: 300,
              initialValue: review.isEmpty() ? "" : review.text,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: Localization.of(context).hintReview,
              ),
              onSaved: (text) => review.text = text,
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
                  Review newReview =
                      await bookManager.saveReview(review, widget.isbn);
                  isModifyMode = false;
                  setState(() => review = newReview);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
