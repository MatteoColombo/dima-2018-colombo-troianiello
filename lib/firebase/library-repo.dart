import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/library.model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import './auth.dart';

class _LibraryControl {
  CollectionReference _db = Firestore.instance.collection("libraries");

  Stream<List<Library>> getLibraryStream() async* {
    String userId = await authService.getUserId();
    Stream<QuerySnapshot> source =
        _db.where("uid", isEqualTo: userId).snapshots();

    await for (QuerySnapshot data in source) {
      List<Library> libList = List<Library>();
      data.documents.forEach((DocumentSnapshot doc) {
        Library lib = Library();
        lib.assimilate(doc);
        libList.add(lib);
      });
      //Sort by preference and then by name
      libList.sort((a, b) {
        if (a.isFavourite && !b.isFavourite) return -1;
        if (b.isFavourite && !a.isFavourite) return 1;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      yield libList;
    }
  }

  void updateFavouritePreference(DocumentReference libRef, bool preference) {
    libRef.updateData({'isFavourite': preference});
  }

  Future<void> saveLibrary(Library lib) async {
    if (lib.reference == null) {
      return _db.document().setData({
        "name": lib.name,
        "isFavourite": lib.isFavourite,
        "image": lib.image,
        "uid": await authService.getUserId()
      });
    } else {
      return _db.document(lib.reference.documentID).updateData({
        "name": lib.name,
        "isFavourite": lib.isFavourite,
        "image": lib.image,
        "uid": await authService.getUserId()
      });
    }
  }

  void deleteLibrary(Library lib) {
    _db.document(lib.reference.documentID).delete();
  }

  Future<String> uploadFile(File image) async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("libraries/${authService.userId}/${basename(image.path)}");
    StorageUploadTask uploadTask = ref.putFile(image);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
}

final _LibraryControl libManager = _LibraryControl();
