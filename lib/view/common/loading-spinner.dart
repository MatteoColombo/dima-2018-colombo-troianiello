import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';

/// Shows a loading dialog with a custom message.
///
/// Receives a [String] msg containing the message that is used as title of the dialog.
class LoadingSpinner extends StatelessWidget {
  LoadingSpinner(this.msg);
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 130,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              msg,
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            leading: CircularProgressIndicator(),
            title: Text(Localization.of(context).wait),
          )
        ],
      ),
    );
  }
}
