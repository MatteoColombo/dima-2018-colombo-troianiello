import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';

/// Shows a checkbox to handle the favourite status.
class FavouriteCheckbox extends StatelessWidget {
  const FavouriteCheckbox({Key key, this.onChange, this.favourite})
      : super(key: key);

  /// The callback function called to update the status.
  final Function onChange;

  /// Whether the library is favourite or not.
  final bool favourite;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(Localization.of(context).favouriteLibrary),
      onChanged: (val) => onChange(val),
      value: favourite,
    );
  }
}
