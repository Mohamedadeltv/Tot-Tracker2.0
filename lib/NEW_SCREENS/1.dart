import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
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

  Widget? screenView;
  DrawerIndex? drawerIndex;
  late final List<Widget> _pages;
  _DashScreenState() {
    _pages = [
      DashScreen(),
      ProfileScreens(),
    ];
  }

  StreamSubscription<DataSnapshot>? subscription;
  String text1 = '';
  String text2 = '';
  final databaseReference = FirebaseDatabase.instance.reference();
  final _navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home ,weight: 20),
      title: const Text(
        "Home",
        style: TextStyle(fontSize: 16),
      ),
      selectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.child_friendly),
      title: Container(),
      selectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.person,weight: 20,),
      title: const Text(
        "Profile",
        style: TextStyle(fontSize: 16),
      ),
      selectedColor: Colors.white,
    ),
  ];
  List<SalomonBottomBarItem> get updatedNavBarItems {
    _navBarItems[1] = SalomonBottomBarItem(
      icon: Image.asset(
        'assets/drawables/tottracker4.png', // Replace with the path to your image
        width: 30, // Adjust the width as needed
        height: 30, // Adjust the height as needed
      ),
      title: Text(
         '',
        style: TextStyle(fontSize: 19),
      ),
      selectedColor:  Colors.white
    );
    return _navBarItems;
  }

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const DashScreen();
    super.initState();
    subscription = databaseReference!
        .child("Vitals/1-setFloat")
        .onValue
        .map((event) => event.snapshot)
        .listen((snapshot) {
      if (snapshot != null) {
        Map<dynamic, dynamic>? values =
            snapshot.value as Map<dynamic, dynamic>?;

        if (values != null) {
          text1 = values["X"]?.toString() ?? '';
          text2 = '${values["rt"]?.toString()}°C' ?? '';

          if (text1 == '0') {
            setState(() {});
            // Perform any action you need when text1 is equal to '0'
            // For example, print a message or update another variable
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            _selectedIndex=0;
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
            _selectedIndex=2;
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
                  border: Border.symmetric(
                    horizontal: BorderSide.none,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SalomonBottomBar(
                  backgroundColor: Color.fromARGB(255, 48, 181, 238),
                  currentIndex: _selectedIndex,
                  selectedItemColor:  Color(0xff1c69a2),
                  unselectedItemColor:  Color(0xff9a3a51),
                  onTap: (index) {
                    if (index == 0) {
                      setState(() {
                        screenView = const DashScreen();
                        changeIndex(DrawerIndex.HOME);
                        _selectedIndex = index;
                      });
                    } else if (index == 1) {
                      setState(() {
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
                  items: updatedNavBarItems,
                ),
              )),
        ),
      ),
    );
  }
}
