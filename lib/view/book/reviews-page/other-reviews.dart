import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/review.model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../common/localization.dart';

class ReviewsSection extends StatefulWidget {
  final List<Review> reviews;
  ReviewsSection({@required this.reviews});
  @override
  _ReviewsSectionState createState() => new _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final List<Color> colors = [
    Color.fromRGBO(140, 100, 50, 1),
    Color.fromRGBO(100, 100, 100, 1),
  ];
  Function _functionSelected;
  List<Function> functions;

  @override
  void initState() {
    super.initState();
    functions = new List<Function>();
    functions.add((Review review) => true);
    for (int i = 1; i < 6; i++)
      functions.add((Review review) => review.score == i);
    _functionSelected = functions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child:Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          title: Text(
            Localization.of(context).otherReviews,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
        ),
        SizedBox(
          height: 50.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ..._buildFilterSection(),
            ],
          ),
        ),
        ..._buildListReviews(widget.reviews.where(_functionSelected).toList()),
      ],
    ),);
  }

  List<Widget> _buildListReviews(List<Review> reviews) {
    reviews.sort((a, b) {
      return (b.date.compareTo(a.date));
    });
    List<Widget> reviewsBlock = new List<Widget>();
    for (Review review in reviews) {
      reviewsBlock.add(Divider());
      reviewsBlock.add(Padding(
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
                    backgroundColor:
                        colors.elementAt(reviews.indexOf(review) % 2),
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
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16.0),
              ),
          ],
        ),
      ));
    }
    return reviewsBlock;
  }

  List<Widget> _buildFilterSection() {
    List<Widget> _filters = new List<Widget>();
    _filters.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
        child: ChoiceChip(
          elevation: 5.0,
          label: Text(Localization.of(context).allReviews.toUpperCase()),
          labelStyle: TextStyle(
            color: Color.fromRGBO(140, 0, 50, 1),
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Colors.white,
          selectedColor: Colors.grey,
          selected: _functionSelected == functions.elementAt(0),
          onSelected: (selected) {
            setState(() {
              _functionSelected = functions.elementAt(0);
            });
          },
        ),
      ),
    );
    for (int i = 5; i > 0; i--)
      _filters.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
          child: ChoiceChip(
            elevation: 5.0,
            label: Row(
              children: <Widget>[
                Text("$i".toUpperCase()),
                Icon(
                  Icons.star,
                  color: Color.fromRGBO(140, 0, 50, 1),
                ),
              ],
            ),
            labelStyle: TextStyle(
              color: Color.fromRGBO(140, 0, 50, 1),
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: Colors.white,
            selectedColor: Colors.grey,
            selected: _functionSelected == functions.elementAt(i),
            onSelected: (selected) {
              setState(() {
                _functionSelected = functions.elementAt(i);
              });
            },
          ),
        ),
      );
    return _filters;
  }
}
