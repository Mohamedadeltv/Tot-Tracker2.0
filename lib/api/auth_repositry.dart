import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import 'package:tottracker/NEW_SCREENS/first_screen.dart';
import 'package:tottracker/NEW_SCREENS/main_screen.dart';
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
        : Get.offAll(() => const FeaturesOverviewScreen());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          firebaseUser.value== null
        ? Get.offAll(() => const MainScreen())
        : Get.offAll(() => const FeaturesOverviewScreen());
    } on FirebaseAuthException catch (e) {
      final ex=SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex=SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }
 Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('FirebaseAuthException occurred: ${e.code}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

   Future<void> logOut() async  => await _auth.signOut();
}
