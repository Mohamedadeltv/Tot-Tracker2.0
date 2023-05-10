import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tottracker/NEW_SCREENS/braceletlist.dart';
import 'package:tottracker/NEW_SCREENS/monitoring_screen.dart';
import 'package:tottracker/NEW_SCREENS/profile_screen.dart';
import 'package:tottracker/NEW_SCREENS/profile_selection.dart';
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
  int _selectedIndex = 0;

  final _navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: Colors.purple,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.person),
      title: const Text("Profile"),
      selectedColor: Colors.teal,
    ),
  ];
  Widget? screenView;
  DrawerIndex? drawerIndex;
  late final List<Widget> _pages;
  _DashScreenState() {
    _pages = [
      DashScreen(),
      ProfileScreens(),
    ];
  }

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
          break;
        case DrawerIndex.Help:
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
            screenView = ProfileSelectionScreen();
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
        if (drawerIndex == DrawerIndex.HOME) {
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
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 206, 204, 204),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SalomonBottomBar(
                  currentIndex: _selectedIndex,
                  selectedItemColor: const Color(0xff6200ee),
                  unselectedItemColor: const Color(0xff757575),
                  onTap: (index) {
                    if (index == 0) {
                      setState(() {
                        screenView = const DashScreen();
                        changeIndex(DrawerIndex.HOME);
                        _selectedIndex = index;
                      });
                    } else {
                      setState(() {
                        screenView = ProfileScreens();
                        changeIndex(DrawerIndex.Profile);
                        _selectedIndex = index;
                      });
                    }
                  },
                  items: _navBarItems,
                ),
              )),
        ),
      ),
    );
  }
}
