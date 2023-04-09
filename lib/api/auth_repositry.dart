import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import 'package:tottracker/NEW_SCREENS/first_screen.dart';
import 'package:tottracker/NEW_SCREENS/main_screen.dart';
import 'package:tottracker/NEW_SCREENS/preFeatures_Screen.dart';
import 'package:tottracker/NEW_SCREENS/signup.dart';
import 'package:tottracker/models/signup_email_password_failure.dart';

class AuthenticationRepositry extends GetxController {
  static AuthenticationRepositry get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
    super.onReady();
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const FirstScreen())
        : Get.offAll(() =>  const FeaturesOverviewScreen());
  }

  dialog(String error) {
    Get.dialog(
      AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(error),
        actions: <Widget>[
          OutlinedButton(
            child: Text('Okay'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value == null
          ? Get.offAll(() => const MainScreen())
          : Get.offAll(() =>  const FeaturesOverviewScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      dialog(ex.message);
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      dialog(ex.message);
      throw ex;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        dialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        dialog('Wrong password provided for that user.');
      } else {
        dialog(e.code);
      }
    } catch (e) {
      dialog(e as String);
    }
  }

  Future<void> logOut() async => await _auth.signOut();
}
