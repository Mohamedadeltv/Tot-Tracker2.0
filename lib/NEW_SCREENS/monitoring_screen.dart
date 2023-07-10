import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tottracker/NEW_SCREENS/app_drawer.dart';
import 'package:tottracker/NEW_SCREENS/baby_cry_analyzer_screen.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import 'package:tottracker/NEW_SCREENS/profile_screen.dart';
import 'package:tottracker/custom_drawer/home_drawer.dart';
import 'package:tottracker/providers/profile_controller.dart';
import '../providers/user.dart' as U;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';

import '../sleep_screen/const.dart';
import '../sleep_screen/custom_clipper.dart';
import '../sleep_screen/detail_screen.dart';
import 'package:firebase_database/firebase_database.dart';

import 'message.dart';

class BoxDash extends StatelessWidget {
  final String Text1;
  final String Text2;
  final String Text3;
  final IconData icon;
  final Color color;

  BoxDash(
      {required this.Text1,
      required this.Text2,
      required this.Text3,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Text1,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  Text2,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  Text3,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: color,
              radius: 35,
              child: Icon(
                icon,
                color: Colors.white,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RowCard extends StatelessWidget {
  final String Text1;
  final String Text2;
  final IconData icon;
  final Color color;
  double? size;

  RowCard(
      {required this.Text1,
      required this.Text2,
      required this.color,
      required this.icon,
      this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size != null ? size : 190,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 8,
        margin: EdgeInsets.all(11),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 35,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Text1,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text2 != '1'
                      ? Text(
                          Text2,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        )
                      : CircularProgressIndicator()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class DashScreen extends StatefulWidget {
  const DashScreen({Key? key}) : super(key: key);

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  DatabaseReference? databaseReference;
  @override
  void initState() {
    databaseReference = FirebaseDatabase.instance.reference();
    drawerIndex = DrawerIndex.HOME;
    screenView = const DashScreen();
    super.initState();
  }

  var _showOnlyFavorites = false;
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  _DashScreenState() {
    _pages = [
      DashScreen(),
      ProfileScreens(),
    ];
  }

  String text1 = '1';
  String text2 = '0';
  String room = '0';
  String heartRate = '0';
  bool color = false;
  void fetchFromDatabase() {
    databaseReference
        ?.child("IMU_LSM6DS3")
        .child("1-setFloat")
        .onValue
        .listen((event) {
      Map<dynamic, dynamic> values =
          event.snapshot.value as Map<dynamic, dynamic>;
      if (values != null) {
        setState(() {
          text1 = values["X"]?.toString() ?? '';
          text2 = values["Y"]?.toString() ?? '';
        });
      }
    });
  }

  void _showBottomSheet(BuildContext context) {
    bool flag = true;
    print(text1);
    if (text1 == '0') {
      flag = false;
    }
    showModalBottomSheet(
      context: context,
      isDismissible: flag,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.child_care,
                size: 80,
                color: Colors.blue,
              ),
              SizedBox(height: 16.0),
              Text(
                'Place your baby\'s hand on the device.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showPopup(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/drawables/tottracker4.png', // Replace with the path to your image
                      width: 100, // Adjust the width as needed
                      height: 100, // Adjust the height as needed
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Attention:Your baby is crying and needs your attention. Analyze the cause using our app\'s advanced feature for better care.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    databaseReference!
                        .child("Vitals/1-setFloat")
                        .update({"c": 0}); // Close the dialog
                  },
                  child: Icon(
                    Icons.close_sharp,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          actions: [],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 160.0;
    int _crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press manually
        if (_selectedIndex == 0) {
          // If we're on the first tab, exit the app
          return true;
        } else {
          // Otherwise, switch to the first tab and consume the back button press
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.lightBlue,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
              left: 20,
              top: 80,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                  children: [
                    TextSpan(
                      text: 'Tot',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    TextSpan(
                      text: 'Tracker',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 50,
            child: Container(
                height: 120,
                width: 120,
                child: Image(
                  image: AssetImage('assets/drawables/tottracker4.png'),
                  height: 200,
                  width: 200,
                  color: Colors.white,
                )),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Add this line to allow the column to take the minimum height necessary
              children: [
                SizedBox(
                  height: 200,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BabyCryAnalyzerScreen(),
                      ),
                    );
                  },
                  child: BoxDash(
                    Text1: "",
                    Text2: "Baby Crying Analyzer",
                    Text3: "",
                    color: Colors.orange,
                    icon: Icons.mic,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        key: UniqueKey(),
                        onTap: () {
                          setState(() {
                            color = !color;
                          });
                        },
                        child: FutureBuilder<DatabaseEvent>(
                          future: databaseReference!
                              .child("Vitals/1-setFloat")
                              .once(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DatabaseEvent> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return RowCard(
                                size: 160,
                                Text1: 'Heart Rate',
                                Text2: heartRate,
                                color: Colors.red,
                                icon: Icons.heart_broken,
                              );
                            }
                            if (snapshot.hasError) {
                              // Handle any potential errors
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.hasData) {
                              DataSnapshot? dataSnapshot =
                                  snapshot.data?.snapshot;

                              if (dataSnapshot != null) {
                                Map<dynamic, dynamic>? values = dataSnapshot
                                    .value as Map<dynamic, dynamic>?;

                                if (values != null) {
                                  heartRate =
                                      '${values["ht"]?.toString().substring(0, 2)}°bpm' ??
                                          '';
                                  text2 = values["Y"]?.toString() ?? '';

                                  return RowCard(
                                    size: 160,
                                    Text1: 'Heart Rate',
                                    Text2: heartRate,
                                    color: Colors.red,
                                    icon: Icons.heart_broken,
                                  );
                                }
                              }
                            }

                            return Text(
                                'No data found'); // Handle the case when there is no data
                          },
                        ),
                      ),
                      GestureDetector(
                        key: UniqueKey(),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return StreamBuilder<DataSnapshot>(
                                stream: databaseReference!
                                    .child("Vitals/1-setFloat")
                                    .onValue
                                    .map((event) => event.snapshot),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DataSnapshot> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While waiting for data, show a loading indicator
                                    return Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.child_care,
                                            size: 80,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(height: 16.0),
                                          Text(
                                            'Place your baby\'s hand on the device.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    // Handle any potential errors
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  if (snapshot.hasData) {
                                    DataSnapshot? dataSnapshot = snapshot.data;

                                    if (dataSnapshot != null) {
                                      Map<dynamic, dynamic>? values =
                                          dataSnapshot.value
                                              as Map<dynamic, dynamic>?;

                                      if (values != null) {
                                        text1 = values["X"]?.toString() ?? '';
                                        text2 = values["bt"]
                                                ?.toString()
                                                .substring(0, 4) ??
                                            '';

                                        if (text1 == '0') {
                                          Navigator.pop(
                                              context); // Close the bottom sheet
                                          // databaseReference!.child("IMU_LSM6DS3/1-setFloat").child("X").set(1);
                                        }

                                        return Container(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.child_care,
                                                size: 80,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(height: 16.0),
                                              Text(
                                                'Place your baby\'s hand on the device.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    }
                                  }

                                  return Text(
                                      'No data found'); // Handle the case when there is no data
                                },
                              );
                            },
                          );
                        },
                        child: StreamBuilder<DataSnapshot>(
                          stream: databaseReference!
                              .child("Vitals/1-setFloat")
                              .onValue
                              .map((event) => event.snapshot),
                          builder: (BuildContext context,
                              AsyncSnapshot<DataSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return RowCard(
                                size: 160,
                                Text1: "Body Temp.",
                                Text2: text2,
                                color: Colors.blueAccent,
                                icon: Icons.thermostat_auto,
                              );
                            }
                            if (snapshot.hasError) {
                              // Handle any potential errors
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.hasData) {
                              DataSnapshot? dataSnapshot = snapshot.data;

                              if (dataSnapshot != null) {
                                Map<dynamic, dynamic>? values = dataSnapshot
                                    .value as Map<dynamic, dynamic>?;

                                if (values != null) {
                                  text1 = values["c"]?.toString() ?? '';
                                  text2 =
                                      '${values["bt"]?.toString().substring(0, 4)}°C' ??
                                          '';
                                  print(text1);
                                  print(text2);

                                  return RowCard(
                                    size: 160,
                                    Text1: "Body Temp.",
                                    Text2: text2,
                                    color: Colors.blueAccent,
                                    icon: Icons.thermostat_auto,
                                  );
                                }
                              }
                            }

                            return Text(
                                'No data found'); // Handle the case when there is no data
                          },
                        ),
                      ),
                      GestureDetector(
                        key: UniqueKey(),
                        onTap: () {},
                        child: StreamBuilder<DataSnapshot>(
                          stream: databaseReference!
                              .child("Vitals/1-setFloat")
                              .onValue
                              .map((event) => event.snapshot),
                          builder: (BuildContext context,
                              AsyncSnapshot<DataSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // While waiting for data, show a loading indicator
                              return RowCard(
                                size: 160,
                                Text1: "Room Temp.",
                                Text2: room,
                                color: Colors.green,
                                icon: Icons.wind_power_rounded,
                              );
                            }
                            if (snapshot.hasError) {
                              // Handle any potential errors
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.hasData) {
                              DataSnapshot? dataSnapshot = snapshot.data;

                              if (dataSnapshot != null) {
                                Map<dynamic, dynamic>? values = dataSnapshot
                                    .value as Map<dynamic, dynamic>?;

                                if (values != null) {
                                  text1 = values["X"]?.toString() ?? '';
                                  room =
                                      '${values["rt"]?.toString().substring(0, 4)}°C' ??
                                          '';
                                  print(text1);
                                  print(room);

                                  return RowCard(
                                    size: 160,
                                    Text1: "Room Temp.",
                                    Text2: room,
                                    color: Colors.green,
                                    icon: Icons.wind_power_rounded,
                                  );
                                }
                              }
                            }

                            return Text(
                                'No data found'); // Handle the case when there is no data
                          },
                        ),
                      ),
                      // GestureDetector(
                      //   key: UniqueKey(),
                      //   onTap: () {setState(() {
                      //     color=!color;
                      //   });},
                      //   child: FutureBuilder<DatabaseEvent>(
                      //     future: databaseReference!
                      //         .child("Vitals/1-setFloat")
                      //         .once(),
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<DatabaseEvent> snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         // While waiting for data, show a loading indicator
                      //         return RowCard(size: 160,
                      //           Text1: 'Room Temp',
                      //           Text2: text2,
                      //           color:Colors.red,
                      //           icon: Icons.heart_broken,
                      //         );
                      //       }
                      //       if (snapshot.hasError) {
                      //         // Handle any potential errors
                      //         return Text('Error: ${snapshot.error}');
                      //       }
                      //       if (snapshot.hasData) {
                      //         DataSnapshot? dataSnapshot =
                      //             snapshot.data?.snapshot;

                      //         if (dataSnapshot != null) {
                      //           Map<dynamic, dynamic>? values = dataSnapshot
                      //               .value as Map<dynamic, dynamic>?;

                      //           if (values != null) {
                      //             text1 = values["X"]?.toString() ?? '';
                      //             text2 = values["Y"]?.toString() ?? '';

                      //             return RowCard(size: 160,
                      //               Text1: 'Room Temp',
                      //               Text2: text2,
                      //               color: Colors.red,
                      //               icon: Icons.heart_broken,
                      //             );
                      //           }
                      //         }
                      //       }

                      //       return Text(
                      //           'No data found'); // Handle the case when there is no data
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      BoxDash(
                        Text1: "Status",
                        Text2: "Sleeping",
                        Text3: "",
                        color: Color(0xff1c69a2),
                        icon: Icons.bedtime_outlined,
                      ),
                    ],
                  ),
                ),
                BabyCryingStreamBuilder()
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
