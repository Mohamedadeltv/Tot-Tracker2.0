import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import 'package:tottracker/NEW_WIDGETS/button.dart';
import '../custom_drawer/app_theme.dart';

class HelpScreen extends StatefulWidget {
  static const routeName = '/helpscreen';

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the previous page
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return false;
      },
      child: Container(
        color: isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor:
                isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/drawables/tottracker4.png'),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 16,
                      right: 16,
                    ),
                    child: Image.asset('assets/drawables/helpImage.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'How can we help you?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isLightMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'It looks like you are experiencing problems\nwith our sign up process. We are here to\nhelp so please get in touch with us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isLightMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MYB(
                    text: "Chat With US",
                    size: 250.0,
                    ontap: () {},
                    text_color: Color.fromARGB(255, 210, 210, 205),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
