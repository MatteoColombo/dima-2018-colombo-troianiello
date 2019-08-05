import 'package:dima2018_colombo_troianiello/firebase/library-repo.dart';
import 'package:dima2018_colombo_troianiello/model/library.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/loading-spinner.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';

class MoveBookDialog extends StatelessWidget {
  const MoveBookDialog({Key key, this.currentLib}) : super(key: key);
  final String currentLib;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: libManager.getUserLibs(currentLib),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SimpleDialog(
              title: Text(Localization.of(context).selectLibrary),
              children: _generateDialogItems(snapshot.data, context));
        } else {
          return LoadingSpinner(Localization.of(context).loadingData);
        }
      },
    );
  }

  _generateDialogItems(List<Library> libs, context) {
    List<SimpleDialogOption> options = [];

    libs.forEach((Library l) => options.add(SimpleDialogOption(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(l.name),
          ),
          onPressed: () => Navigator.of(context).pop(l.id),
        )));

    return options;
  }
}
