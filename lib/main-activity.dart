import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/view/library/new-library.dart';
import 'package:dima2018_colombo_troianiello/view/library/library-list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './firebase/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainActivity extends StatefulWidget {
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  FirebaseUser _user;
  String _initials;

  _MainActivityState() {
    _initUser();
  }

  _initUser() {
    _user = authService.getUser();
    List<String> name = _user.displayName.split(" ");
    _initials = name.first.substring(0, 1).toUpperCase() +
        name.last.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NonSoloLibri"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => null,
          )
        ],
      ),
      drawer: _drawer(),
      body: LibraryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => NewLibrary()),
        child: Icon(Icons.add),
      ),
    );
  }

  _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("${_user?.displayName}"),
              accountEmail: Text("${_user?.email}"),
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  width: 40,
                  height: 40,
                  placeholder: (context, _) => Container(
                    color: Colors.green,
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      _initials,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ),
                  imageUrl: _user != null && _user.photoUrl != null
                      ? _user.photoUrl
                      : "",
                ),
              )),
          ListTile(
            leading: Icon(
              MdiIcons.settings,
              color: Colors.black54,
            ),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(MdiIcons.logout, color: Colors.black54),
            title: Text('Log out'),
            onTap: () {
              authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}
