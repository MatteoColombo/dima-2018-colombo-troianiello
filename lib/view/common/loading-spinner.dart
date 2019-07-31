import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 130,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("Saving new library",style: TextStyle(fontSize: 18),),
          ),
          ListTile(
            leading: CircularProgressIndicator(),
            title: Text("please wait..."),
          )
        ],
      ),
    );
  }
}
