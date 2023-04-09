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


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthenticationRepositry()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          ForgetPasswordSreen.routeName: (ctx) => ForgetPasswordSreen(),
          FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
          HelpScreen.routeName: (ctx) => HelpScreen(),
          InviteFriend.routeName: (ctx) => InviteFriend(),
        },
      ),
    );
  }
}
