import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/feature_detail_screen.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import 'package:tottracker/NEW_SCREENS/feedback_screen.dart';
import 'package:tottracker/NEW_SCREENS/first_screen.dart';
import 'package:tottracker/NEW_SCREENS/forget_password_screen.dart';
import 'package:tottracker/NEW_SCREENS/help_screen.dart';
import 'package:tottracker/NEW_SCREENS/invite_friend_screen.dart';
import 'package:tottracker/NEW_SCREENS/main_screen.dart';
import 'package:tottracker/NEW_SCREENS/profile_screen.dart';
import 'package:tottracker/NEW_SCREENS/signin.dart';
import 'package:tottracker/NEW_SCREENS/signup.dart';
import 'package:provider/provider.dart';
import 'package:tottracker/api/auth_repositry.dart';
import 'package:tottracker/providers/features.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepositry()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
                    Navigator.pop(context); // Close the dialog
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //hna b-provide kol el child widgets be a Product class instance
          create: (ctx) => Features(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        home: CircularProgressIndicator(),
        routes: {
          FeaturesOverviewScreen.routeName: (ctx) => FeaturesOverviewScreen(),
          FeatureDetailScreen.routeName: (ctx) => FeatureDetailScreen(),
          MainScreen.routeName: (ctx) => MainScreen(),
          ProfileScreens.routeName: (ctx) => ProfileScreens(),
          ForgetPasswordSreen.routeName: (ctx) => ForgetPasswordSreen(),
          FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
          HelpScreen.routeName: (ctx) => HelpScreen(),
          InviteFriend.routeName: (ctx) => InviteFriend(),
        },
      ),
    );
  }
}
