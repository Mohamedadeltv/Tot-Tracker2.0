import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:tottracker/NEW_SCREENS/feedback_screen.dart';
import 'package:tottracker/NEW_SCREENS/help_screen.dart';
import 'package:tottracker/NEW_SCREENS/invite_friend_screen.dart';
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
               
               Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ));
              }),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('Help'),
              onTap: () {
               Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpScreen(),
                          ));
              }),
          ListTile(
              leading: Icon(Icons.help),
              title: Text('Feedback'),
              onTap: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedbackScreen(),
                          ));
              }),
          ListTile(
              leading: Icon(Icons.group),
              title: Text('Invite A Friend'),
              onTap: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InviteFriend(),
                          ));
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
