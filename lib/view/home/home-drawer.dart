import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key key, this.user, this.initials}) : super(key: key);
  final FirebaseUser user;
  final String initials;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("${user?.displayName}"),
              accountEmail: Text("${user?.email}"),
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
                      initials,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ),
                  imageUrl: user != null && user.photoUrl != null
                      ? user.photoUrl
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
