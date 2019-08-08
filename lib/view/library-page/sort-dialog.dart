import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/sort-books-enum.dart';
import 'package:flutter/material.dart';

/// Shows a dialog with some options to sort the book list.
class SortDialog extends StatelessWidget {
  const SortDialog({Key key, this.sort}) : super(key: key);

  /// The current sort method.
  final SortMethods sort;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(Localization.of(context).sortingOptions),
      contentPadding: EdgeInsets.all(8),
      children: _generateOptions(context),
    );
  }

  /// Returns the list of possible sorting methods.
  ///
  /// For each possible sorting option a [SimpleDialogOption] is created.
  List<SimpleDialogOption> _generateOptions(BuildContext context) {
    List<SimpleDialogOption> options = [];
    // Get the sorting options text.
    List<String> messages = _generateMessages(context);
    for (int i = 0; i < messages.length; i++) {
      options.add(
        SimpleDialogOption(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    sort == SortMethods.values[i]
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(messages[i]),
              ],
            ),
          ),
          onPressed: () => Navigator.pop(context, SortMethods.values[i]),
        ),
      );
    }
    return options;
  }

  /// Returns a list of sorting options text.
  ///
  /// We need this method and we can't declare this as a costant because of Localization.
  List<String> _generateMessages(BuildContext context) {
    return [
      Localization.of(context).sortAZ,
      Localization.of(context).sortZA,
      Localization.of(context).sortNewest,
      Localization.of(context).sortOldest,
    ];
  }
}
