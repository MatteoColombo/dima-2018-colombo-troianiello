import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;/*FutureBuilder(
      future: bookManager.getReviews(isbn),
      builder: (BuildContext context, AsyncSnapshot<List<Review>> snapshot) {
        if (!snapshot.hasData)
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        else {
            return _build(context, snapshot.data);
        }
      },
    );*/
  }
}
