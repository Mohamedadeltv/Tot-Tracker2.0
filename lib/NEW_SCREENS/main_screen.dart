import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/signin.dart';
import 'package:tottracker/NEW_SCREENS/signup.dart';
import 'package:tottracker/widgets/title_of_app.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/mainscreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _signup = false;
  var _signin = true;
  void toggle() {
    setState(() {
    _signup = !_signup;
    _signin = !_signin;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final dynamic appBar = AppBar(
      backgroundColor: Color.fromARGB(255, 15, 53, 143),
      title: TitleOfApp(),
      actions: [
        OutlinedButton(
          style: ButtonStyle(
              backgroundColor: _signin
                  ? MaterialStateProperty.all<Color>(Color(0xff9a3a51))
                  : MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 15, 53, 143))),
          onPressed: () {
            setState(() {
              if (_signin) {
              } else {
                _signin = !_signin;
                _signup = !_signup;
              }
            });
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
        OutlinedButton(
          style: ButtonStyle(
              backgroundColor: _signup
                  ? MaterialStateProperty.all<Color>(Color(0xff9a3a51))
                  : MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 15, 53, 143))),
          onPressed: () {
            setState(() {
              if (_signup) {
              } else {
                _signup = !_signup;
                _signin = !_signin;
              }
            });
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      appBar: appBar,
      body: _signin ? signin(toggle) : signup(),
    );
  }
}
