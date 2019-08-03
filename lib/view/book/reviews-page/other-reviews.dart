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
  List<Color> colors;
  Function _functionSelected;
  List<Function> functions;

  @override
  void initState() {
    super.initState();
    colors = [
      Color.fromRGBO(140, 100, 50, 1),
      Color.fromRGBO(100, 100, 100, 1),
    ];
    functions = new List<Function>();
    functions.add((Review review) => true);
    for (int i = 1; i < 6; i++)
      functions.add((Review review) => review.score == i);
    _functionSelected = functions.first;
  }

  @override
  Widget build(BuildContext context) {
    widget.reviews.sort((a, b) {
      return (b.date.compareTo(a.date));
    });
    return Column(
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
        _ListReviews(reviews: widget.reviews.where(_functionSelected).toList()),
        //..._buildReviews(reviews.where(_functionSelected).toList()),
      ],
    );
  }

  List<Widget> _buildReviews(List<Review> reviews) {
    reviews.sort((a, b) {
      return -(a.date.compareTo(b.date));
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

class _ListReviews extends StatefulWidget {
  _ListReviews({Key key, @required this.reviews}) : super(key: key);
  final List<Review> reviews;

  @override
  _ListReviewState createState() => new _ListReviewState();
}

class _ListReviewState extends State<_ListReviews> {
  int present;
  int perPage;
  ScrollController controller;
  List<Review> items;
  List<Color> colors;

  @override
  void initState() {
    super.initState();
    present = 0;
    if (widget.reviews.length < 3)
      perPage = widget.reviews.length;
    else
      perPage = 3;
    colors = [
      Color.fromRGBO(140, 100, 50, 1),
      Color.fromRGBO(100, 100, 100, 1),
    ];
    items = List<Review>();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        items.addAll(widget.reviews.getRange(present, present+perPage-1));
        present=present+perPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        controller: controller,
        itemCount: widget.reviews.length,
        itemBuilder: (context, index) {
          return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.all(0.0),
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              child: Text(
                                widget.reviews[index].user,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: colors.elementAt(index % 2),
                              radius: 25,
                            ),
                          ],
                        ),
                        title: FlutterRatingBar(
                          allowHalfRating: false,
                          itemCount: 5,
                          initialRating: widget.reviews[index].score.toDouble(),
                          fillColor: Colors.grey,
                          borderColor: Colors.grey,
                          itemSize: 15.0,
                          ignoreGestures: true,
                          onRatingUpdate: (v) {},
                        ),
                        subtitle: Text(DateFormat(' d MMMM y')
                            .format(widget.reviews[index].date)),
                      ),
                      if (widget.reviews[index].text.length != 0)
                        Text(
                          '"' + widget.reviews[index].text + '"',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 16.0),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
