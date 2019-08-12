import 'package:cached_network_image/cached_network_image.dart';
import 'package:dima2018_colombo_troianiello/firebase-provider.dart';
import 'package:dima2018_colombo_troianiello/model/user.model.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// Main application drawer.
///
/// It shows a Box with user's profile picture, name and email.
/// It shows a list with some options.
class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key key, this.user}) : super(key: key);

  /// Represents the current user.
  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("${user?.name}"),
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
                    //While loading user profile picuter, show his name initials.
                    child: Text(
                      user?.initials,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ),
                  // If user has a photo and if user has loaded, show its profile picture.
                  imageUrl:
                      user != null && user.imgUrl != null ? user.imgUrl : "",
                ),
              )),
          // Shows the settings page.
          ListTile(
            leading: Icon(
              MdiIcons.settings,
              color: Colors.black54,
            ),
            title: Text(Localization.of(context).settings),
            onTap: null,
          ),
          // Calls the method to sign out.
          ListTile(
            leading: Icon(MdiIcons.logout, color: Colors.black54),
            title: Text(Localization.of(context).logout),
            onTap: () => FireProvider.of(context).auth.logout(),
          ),
        ],
      ),
    );
  }
}
