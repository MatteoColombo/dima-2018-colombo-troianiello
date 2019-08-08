import 'package:flutter/material.dart';
import 'localization.dart';

///Shows the [text] in a contracted form or a extended form.
class DescriptionTextWidget extends StatefulWidget {
  ///The message to be shown.
  final String text;

  ///Constructor of DescriptionTextWidget.
  ///
  ///[text] is the message to be shown, is required and must be not null.
  DescriptionTextWidget({@required this.text}) : assert(text != null);

  //Creates the state of DescriptionTextWidget.
  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  ///The first half of [widget.text].
  ///
  ///Contains the substring start from index 0 to 149 of [widget.text].
  String _firstHalf;

  ///The second half of [widget.text].
  ///
  ///Contains the substring start from index 150 to the end of [widget.text].
  String _secondHalf;

  ///Indicates if [widget.text] is shown in a contracted form or a extended form.
  ///
  ///If [_flag] is true, [_firstHalf] is shown.
  ///Otherwise, is shown a concatenation of [_firstHalf] and [_secondHalf]
  ///(the full version of [widget.text]).
  bool flag = true;

  //Initializes [_firstHalf],[_secondHalf] and [_flag].
  //If [widget.text.length] is <150, [_secondHalf] is initialized with "".
  //[_flag] is initialized with true.
  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      _firstHalf = widget.text.substring(0, 150);
      _secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      _firstHalf = widget.text;
      _secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: _secondHalf.isEmpty
          ? Text(_firstHalf)
          : Column(
              children: <Widget>[
                Text(flag ? (_firstHalf + "...") : (_firstHalf + _secondHalf)),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag
                            ? Localization.of(context).showMore
                            : Localization.of(context).showLess,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
