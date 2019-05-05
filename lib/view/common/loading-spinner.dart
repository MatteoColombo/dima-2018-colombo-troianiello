import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300].withOpacity(0.5),
      child: Center(
        child: Theme(
          child: SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(
              strokeWidth: 10.0,
            ),
          ),
          data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
        ),
      ),
    );
  }
}
