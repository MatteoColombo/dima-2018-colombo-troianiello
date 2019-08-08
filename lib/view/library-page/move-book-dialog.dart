import 'package:dima2018_colombo_troianiello/firebase-provider.dart';
import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/loading-spinner.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';

/// Shows a dialog to ask the user to which library he wants to move the books.
class MoveBookDialog extends StatelessWidget {
  const MoveBookDialog({Key key, this.currentLib}) : super(key: key);

  /// The current library id.
  final String currentLib;

  /// The function used to render the widget.
  ///
  /// If the list of libraries is still loading, show a progress indicator.
  /// If the list is loaded, show a [SimpleDialog] with some options.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireProvider.of(context).library.getUserLibraries(
            currentLib,
            FireProvider.of(context).auth.getUserId(),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SimpleDialog(
              title: Text(Localization.of(context).selectLibrary),
              children: _generateDialogItems(snapshot.data, context));
        } else {
          return Dialog(
            child: LoadingSpinner(Localization.of(context).loadingData),
          );
        }
      },
    );
  }

  /// Returns a list of dialog items, each one represents a library.
  ///
  /// Takes a [List<Library>], filters the current library and returns a list of [SimpleDialogOption].
  List<SimpleDialogOption> _generateDialogItems(List<Library> libs, context) {
    List<SimpleDialogOption> options = [];

    libs.forEach((Library l) => options.add(SimpleDialogOption(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(l.name),
          ),
          onPressed: () => Navigator.of(context).pop(l.id),
        )));

    if (options.length == 0) Navigator.of(context).pop();
    return options;
  }
}
