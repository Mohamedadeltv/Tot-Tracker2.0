import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tottracker/api/auth_repositry.dart';
import 'package:tottracker/api/user_repositry.dart';
import 'package:tottracker/providers/user.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  final countryController = TextEditingController();
  final userRepo = Get.put(UserRepositry());

void createUser(String email, String password) {
    AuthenticationRepositry.instance.createUserWithEmailAndPassword(email, password);
  }
   Future<void> registerUser(User user) async {
    await userRepo.createuser(user);
  }
}
