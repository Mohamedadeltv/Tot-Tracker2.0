import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/braceletlist.dart';
import 'package:tottracker/NEW_SCREENS/monitoring_screen.dart';
import 'package:tottracker/NEW_SCREENS/profile_screen.dart';

import '../custom_drawer/drawer_user_controller.dart';
import '../custom_drawer/home_drawer.dart';
import 'aboutus.dart';
import 'drag.dart';
import 'feedback_screen.dart';
import 'help_screen.dart';
import 'invite_friend_screen.dart';

class BeginningScreen extends StatefulWidget {
  const BeginningScreen({Key? key}) : super(key: key);

  @override
  State<BeginningScreen> createState() => _BeginningScreenState();
}

class _BeginningScreenState extends State<BeginningScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const DashScreen();
    super.initState();
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const DashScreen();
          });
          break;case DrawerIndex.Help:
          setState(() {
            screenView = HelpScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = InviteFriend();
          });
          break;
        case DrawerIndex.Profile:
          setState(() {
            screenView = ProfileScreens();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = InviteFriend();
          });
          break;
        case DrawerIndex.ManageBracelet:
          setState(() {
            screenView = ArrowWidget();
          });
          break;
        case DrawerIndex.About:
          setState(() {
            screenView = AboutUsPage();
          });
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press manually
        if (drawerIndex==DrawerIndex.HOME) {
          // If we're on the first tab, exit the app
          return true;
        } else {
          // Otherwise, switch to the first tab and consume the back button press
          setState(() {
           drawerIndex = DrawerIndex.HOME;
            screenView = const DashScreen();
          });
          return false;
        }
      },
      child: Container(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            body: DrawerUserController(
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
                //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
              },
              screenView: screenView,
              //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
            ),
          ),
        ),
      ),
    );
  }
}
