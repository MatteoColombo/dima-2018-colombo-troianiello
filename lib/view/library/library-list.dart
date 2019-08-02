import 'package:dima2018_colombo_troianiello/view/library/book-list.dart';
import 'package:dima2018_colombo_troianiello/view/library/edit-library.dart';
import 'package:flutter/material.dart';
import '../../firebase/library-repo.dart';
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
                return InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BookList(
                            library: l,
                          ))),
                  child: Card(
                    elevation: 8,
                    margin: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 16, right: 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Hero(
                              child: l.image != null
                                  ? CachedNetworkImage(
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                      imageUrl: l.image,
                                      placeholder: (context, _) => Container(
                                        width: 90,
                                        height: 90,
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator()),
                                      ),
                                    )
                                  : Image.asset(
                                      "assets/images/library.jpeg",
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                              tag: l.id,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                trailing: IconButton(
                                  onPressed: () => _changeFavouriteState(l),
                                  iconSize: 32,
                                  icon: Icon(
                                    l.isFavourite
                                        ? Icons.star
                                        : Icons.star_border,
                                  ),
                                ),
                                title: Text(l.name),
                                subtitle:
                                    Text('Contiene ${l.bookCount ?? 0} libri'),
                              ),
                              ButtonTheme.bar(
                                padding: EdgeInsets.zero,
                                // make buttons use the appropriate styles for cards
                                child: ButtonBar(
                                  children: <Widget>[
                                    IconTheme(
                                      data: IconThemeData(
                                          color: Colors.grey[500]),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16, bottom: 2),
                                        child: PopupMenuButton(
                                          onSelected: (val) =>
                                              _handleCardMenu(val, l, context),
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                value: 0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 16),
                                                      child: Icon(Icons.edit),
                                                    ),
                                                    Text("Edit Library")
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 1,
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 16),
                                                      child: Icon(Icons.delete),
                                                    ),
                                                    Text("Delete Library")
                                                  ],
                                                ),
                                              ),
                                            ];
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }

  _handleCardMenu(int val, Library lib, BuildContext context) async {
    print(lib);
    if (val == 0) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => EditLibrary(
          library: lib,
        ),
      );
    } else if (val == 1) {
      bool confirm = await ConfirmDialog().instance(context, "Are you sure?");
      if (confirm ?? false) {
        libManager.deleteLibrary(lib);
      }
    }
  }

  _changeFavouriteState(Library library) {
    libManager.updateFavouritePreference(
        library.id, !library.isFavourite);
  }
}
