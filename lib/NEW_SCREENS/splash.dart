import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/signin.dart';
import 'package:tottracker/NEW_SCREENS/signup.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screen();
}

class _splash_screen extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => signup()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff3F3C3C),
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 400,
            width: 400,
            child: Image.asset('assets/drawables/tottracker4.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "AI-driven",
                style: TextStyle(
                    color: Color(0xff1c69a2),
                    fontFamily: 'Silom',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " Baby monitoring",
                style: TextStyle(
                    color: Color(0xff9a3a51),
                    fontFamily: 'Silom',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " Application",
                style: TextStyle(
                    color: Color(0xff1c69a2),
                    fontFamily: 'Silom',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
