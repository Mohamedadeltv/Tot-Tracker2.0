import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tottracker/api/auth_repositry.dart';
import 'package:tottracker/api/user_repositry.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();
  final _authRepo= Get.put(AuthenticationRepositry());
  final _userRepo= Get.put(UserRepositry());
  getUserData(){
    final email=_authRepo.firebaseUser.value?.email;
  print('email: $email');
  if(email!=null){
    final userDetails = _userRepo.getUserDetails(email);
    print('userDetails: $userDetails');
    return userDetails;
  } else{
    Get.snackbar('Error', 'Login to continue');}

  }
}