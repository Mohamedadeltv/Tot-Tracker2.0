import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import 'package:tottracker/providers/profile_controller.dart';
import '../providers/user.dart' as U;
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  static const routeName = '/profile';
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 15, 53, 143)),
        ),
        centerTitle: true,
        title: const Center(
          child: Text(
            'Profile Screen',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => FeaturesOverviewScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  print("yessssssss");
                  U.User userData = snapshot.data as U.User;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Stack(children: [
                        CircleAvatar(
                          backgroundColor: Colors.amberAccent,
                          minRadius: 65.0,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: AssetImage(
                                'assets/drawables/istockphoto-1179420343-612x612.jpg'),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 140,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.amberAccent,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 25,
                              ),
                            ))
                      ]),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Form(
                          child: Column(
                        children: [
                          TextFormField(
                            initialValue: userData.name ?? '',
                            decoration: InputDecoration(
                                label: Text(
                                  'Name : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                prefixIcon: Icon(
                                    size: 30,
                                    Icons.person,
                                    color: Color(0xff9a3a51))),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            initialValue: userData.email ?? '',
                            decoration: InputDecoration(
                                label: Text(
                                  'Email : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                prefixIcon: Icon(
                                  size: 30,
                                  Icons.email,
                                  color: Color(0xff1c69a2),
                                )),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            initialValue: userData.gender ?? '',
                            decoration: InputDecoration(
                                label: Text(
                                  'Gender : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                prefixIcon: Icon(
                                    size: 30,
                                    Icons.male,
                                    color: Color(0xff9a3a51))),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            initialValue: userData.country ?? '',
                            decoration: InputDecoration(
                              label: Text(
                                'Country : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              prefixIcon: Icon(
                                size: 30,
                                Icons.countertops,
                                color: Color(0xff1c69a2),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      )),
                    ],
                  );
                } else if (snapshot.hasError) {
                  print("no");
                  print("Error while fetching user data: ${snapshot.error}");
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  print("noooo");
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
