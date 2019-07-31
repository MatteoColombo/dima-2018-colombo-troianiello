import 'package:flutter/material.dart';
import '../../firebase/library-repo.dart';
import './library-options.dart';
import './list-options-enum.dart';
import '../../model/library.model.dart';
import '../common/confirm-dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LibraryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: libManager.getLibraryStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Library>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.grey[400]),
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.data.length == 0) {
            return Center(
              child: Image.asset(
                "assets/images/stack.png",
                width: 150,
              ),
            );
          } else {
            List<Library> libraries = snapshot.data;

            return ListView.builder(
              itemCount: libraries.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, i) {
                Library l = libraries[i];
                return Card(
                  elevation: 8,
                  margin: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 16, right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: l.image != null
                              ? Image.network(
                                  l.image,
                                  alignment: Alignment.center,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/library.jpeg",
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              trailing: IconButton(
                                onPressed: () => null,
                                iconSize: 32,
                                icon: Icon(
                                  l.isFavourite
                                      ? Icons.star
                                      : Icons.star_border,
                                ),
                              ),
                              title: Text(l.name),
                              subtitle: Text('Contiene 22 libri'),
                            ),
                            ButtonTheme.bar(
                              padding: EdgeInsets.zero,
                              // make buttons use the appropriate styles for cards
                              child: ButtonBar(
                                
                                children: <Widget>[
                                  FlatButton(
                                    child: const Text('OPEN'),
                                    onPressed: () {/* ... */},
                                  ),
                                  FlatButton(
                                    child: const Text('EDIT'),
                                    onPressed: () {/* ... */},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }
      },
    );
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
          ? CachedNetworkImage(
              width: 50,
              height: 50,
              fit: BoxFit.fitWidth,
              imageUrl: _library.image,
              placeholder: (context, url) => Theme(
                  data:
                      Theme.of(context).copyWith(accentColor: Colors.grey[400]),
                  child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.asset(
                  "assets/images/library.jpeg",
                  width: 50,
                  height: 50,
                  fit: BoxFit.fitHeight),
            )
          : Image.asset(
              "assets/images/library.jpeg",
              width: 50,
              height: 50,
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
          /*Navigator.push(
            context,
            /MaterialPageRoute(
                builder: (BuildContext context) => EditLibrary(
                      isNew: false,
                      library: _library,
                    )),
          );*/
        }
      }),
    );
  }
}
