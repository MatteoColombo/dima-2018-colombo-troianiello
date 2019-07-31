import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/review.model.dart';
import '../../firebase/book-repo.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
            _NewReviewSection(
              isbn: isbn,
              addBook: addBook,
            ),
            _build(context),
          ],
        ),
      ],
    );
  }

  Widget _build(BuildContext context) {
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
          return _buildReviews(snapshot.data);
        }
      },
    );
  }

  Widget _buildReviews(List<Review> reviews) {
    List<Widget> reviewsBlock = new List<Widget>();
    for (Review review in reviews) {
      reviewsBlock.add(Divider());
      reviewsBlock.add(ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(
                    child: Text(review.user),
                    backgroundColor: Colors.black87,
                    radius: 30,
                  ),
                ],
              ),
              title: FlutterRatingBar(
                allowHalfRating: false,
                itemCount: 5,
                initialRating: review.score.toDouble(),
                fillColor: Colors.red,
                borderColor: Colors.red,
                itemSize: 15.0,
                ignoreGestures: true,
                onRatingUpdate: (v) {},
              ),
              subtitle: Text(DateFormat(' d MMMM y').format(review.date)),
            ),
            Text(
              '"' + review.text + '"',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ));
    }
    return Column(
      children: <Widget>[
        ...reviewsBlock,
        Divider(
          color: Colors.transparent,
        )
      ],
    );
  }
}

class _NewReviewSection extends StatefulWidget {
  final String isbn;
  final bool addBook;
  _NewReviewSection({@required this.isbn, @required this.addBook});

  @override
  _NewReviewSectionState createState() => new _NewReviewSectionState();
}

class _NewReviewSectionState extends State<_NewReviewSection> {
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
              "Recensioni",
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
            fillColor: Colors.red,
            borderColor: Colors.red,
            itemSize: 30.0,
          ),
          ListTile(
            title: TextFormField(
              maxLines: 8,
              maxLength: 300,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Scrivi una recensione',
              ),
              validator: (text) {
                if (text.length == 0)
                  return "Il testo non deve essere vuoto";
                else
                  return null;
              },
              onSaved: (text) => newReview.text=text,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              child: Text(
                "Invia",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 17.0,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate() && !widget.addBook){
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
