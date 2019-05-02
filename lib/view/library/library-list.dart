import 'package:flutter/material.dart';
import '../../firebase/library-repo.dart';
import './library-options.dart';
import './list-options-enum.dart';
import '../../model/library.model.dart';
import '../common/confirm-dialog.dart';
import './edit-library.dart';

class LibraryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Librerie"),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditLibrary(isNew: true),
                    ),
                  ),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: libManager.getLibraryStream(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Library>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Nessuna libreria"),
              );
            } else {
              List<Library> libraries = snapshot.data;

              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: (libraries.length) * 2,
                itemBuilder: (context, i) {
                  if (i % 2 == 1) return Divider();
                  return LibraryListItem(libraries[i ~/ 2]);
                },
              );
            }
          },
        ));
  }
}

class LibraryListItem extends StatelessWidget {
  LibraryListItem(this._library);

  final Library _library;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_library.name),
      leading: _library.image != null
          ? Image.network(
              _library.image,
              width: 50,
              height: 50,
              fit: BoxFit.fitWidth,
            )
          : Image.asset(
              "images/library.jpeg",
              height: 50,
              width: 50,
              fit: BoxFit.fitHeight,
            ),
      trailing: IconButton(
        icon: Icon(
          _library.isFavourite ? Icons.star : Icons.star_border,
          color: Colors.red,
        ),
        onPressed: () => libManager.updateFavouritePreference(
            _library.reference, !_library.isFavourite),
      ),
      onLongPress: () =>
          OptionsDialog().showOptionsDialog(context).then((LibraryOption res) {
            if (res == LibraryOption.Delete) {
              ConfirmDialog()
                  .instance(context, "Vuoi cancellare la libreria?")
                  .then((bool answer) {
                if (answer) {
                  libManager.deleteLibrary(_library);
                }
              });
            } else if (res == LibraryOption.Edit) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => EditLibrary(
                          isNew: false,
                          library: _library,
                        )),
              );
            }
          }),
    );
  }
}
