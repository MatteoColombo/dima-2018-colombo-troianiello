import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/library.model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

class _LibraryControl {
  CollectionReference _db = Firestore.instance.collection("libraries");

  Stream<List<Library>> getLibraryStream() {
    return _db.snapshots().map((QuerySnapshot snap) {
      List<Library> libList = List<Library>();
      snap.documents.forEach((DocumentSnapshot doc) {
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
      return libList;
    });
  }

  void updateFavouritePreference(DocumentReference libRef, bool preference) {
    libRef.updateData({'isFavourite': preference});
  }

  Future<void> saveLibrary(Library lib) {
    if (lib.reference == null) {
      return _db.document().setData({
        "name": lib.name,
        "isFavourite": lib.isFavourite,
        "image": lib.image
      });
    } else {
      return _db.document(lib.reference.documentID).updateData({
        "name": lib.name,
        "isFavourite": lib.isFavourite,
        "image": lib.image
      });
    }
  }

  void deleteLibrary(Library lib) {
    _db.document(lib.reference.documentID).delete();
  }

  Future<String> uploadFile(File image) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("${user.uid}/${basename(image.path)}");
    StorageUploadTask uploadTask = ref.putFile(image);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
}

final _LibraryControl libManager = _LibraryControl();
