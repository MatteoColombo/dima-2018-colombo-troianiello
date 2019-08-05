import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:dima2018_colombo_troianiello/view/library-page/sort-books-enum.dart';
import 'package:flutter/material.dart';

class SortDialog extends StatelessWidget {
  const SortDialog({Key key, this.sort}) : super(key: key);

  final SortMethods sort;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(Localization.of(context).sortingOptions),
      contentPadding: EdgeInsets.all(8),
      children: _generateOptions(context),
    );
  }

  _generateOptions(BuildContext context) {
    List<SimpleDialogOption> options = [];
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

  _generateMessages(BuildContext context) {
    return [
      Localization.of(context).sortAZ,
      Localization.of(context).sortZA,
      Localization.of(context).sortNewest,
      Localization.of(context).sortOldest,
    ];
  }
}
