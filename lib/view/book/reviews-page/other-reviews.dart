import 'package:flutter/material.dart';
import '../../../model/review.model.dart';
import '../../common/localization.dart';
import './review-widget.dart';

///Shows all reviews made by other users.
class ReviewsSection extends StatefulWidget {
  ///List of [Review] to show.
  final List<Review> reviews;

  ///Constructor of ReviewsSection.
  ///
  ///[reviews] is required and is the list of [Review] to show.
  ReviewsSection({@required this.reviews});

  //Creates the state of [ReviewsSection].
  @override
  _ReviewsSectionState createState() => new _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  ///The backgound colors of the user informations section.
  final List<Color> _colors = const [
    Color.fromRGBO(140, 100, 50, 1),
    Color.fromRGBO(100, 100, 100, 1),
  ];

  ///The filter funtion selected.
  Function _functionSelected;

  ///The filter functions available.
  List<Function> _functions;

  //Initializes [_functionSelected] with a default funtions and fills [_functions].
  @override
  void initState() {
    super.initState();
    _functions = new List<Function>();
    _functions.add((Review review) => true);
    for (int i = 1; i < 6; i++)
      _functions.add((Review review) => review.score == i);
    _functionSelected = _functions.first;
  }

  //Returns a [Columns], containing a [ListView], that controls the filters,
  //and a [List] of generated widgets, each associated to a specific [Review].
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
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
          //Filters the [widget.reviews] with [_functionSelected].
          ..._buildListReviews(
              widget.reviews.where(_functionSelected).toList()),
        ],
      ),
    );
  }

  ///Returns a [List] of [Widget] associated to [reviews].
  ///
  ///Sorts the [reviews] and creates the widgets.
  List<Widget> _buildListReviews(List<Review> reviews) {
    reviews.sort((a, b) {
      return (b.date.compareTo(a.date));
    });
    List<Widget> reviewsBlock = new List<Widget>();
    for (Review review in reviews) {
      reviewsBlock.add(Divider());
      reviewsBlock.add(
        ReviewWidget(
          review: review,
          color: _colors.elementAt(reviews.indexOf(review) % 2),
        ),
      );
    }
    return reviewsBlock;
  }

  ///Returns the chips associated to the filter functions, [_functions].
  List<Widget> _buildFilterSection() {
    List<Widget> _filters = new List<Widget>();
    //Filter 'ALL'.
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
          selected: _functionSelected == _functions.elementAt(0),
          onSelected: (selected) {
            setState(() {
              _functionSelected = _functions.elementAt(0);
            });
          },
        ),
      ),
    );
    //Filter 'n Star'.
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
            selected: _functionSelected == _functions.elementAt(i),
            onSelected: (selected) {
              setState(() {
                _functionSelected = _functions.elementAt(i);
              });
            },
          ),
        ),
      );
    return _filters;
  }
}
