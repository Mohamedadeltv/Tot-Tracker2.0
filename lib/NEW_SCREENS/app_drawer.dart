import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:tottracker/NEW_SCREENS/profile_screen.dart';
import 'package:tottracker/api/auth_repositry.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Color.fromARGB(255, 15, 53, 143),
            title: Text('Hello friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ProfileScreen.routeName);
              }),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('Features'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FeaturesOverviewScreen.routeName);
              }),
          ListTile(
              leading: Icon(Icons.mail),
              title: Text('Contact'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FeaturesOverviewScreen.routeName);
              }),
          ListTile(
              leading: Icon(Icons.question_mark),
              title: Text('FAQ'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FeaturesOverviewScreen.routeName);
              }),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                AuthenticationRepositry.instance.logOut();
              }),
        ],
      ),
    );
  }
}
