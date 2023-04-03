import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tottracker/providers/user.dart';
import 'package:flutter/material.dart';

class UserRepositry extends GetxController {
  static UserRepositry get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  createuser(User user) async {
    QuerySnapshot snapshot = await _db
        .collection("Users")
        .where('email', isEqualTo: user.email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return;
    }

    await _db
        .collection("Users")
        .add(user.toJson())
        .then((value) => Get.snackbar(
              "Success",
              "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.black87,
              colorText: Colors.white,
            ))
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black38,
          colorText: Colors.blue);
      print(error.toString());
    });
  }

  Future<User> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("email", isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs.map((e) => User.fromSnapshot(e)).single;
      return userData;
    } else {
      throw Exception("No user found with email $email");
    }
  }

  Future<List<User>> allUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => User.fromSnapshot(e)).toList();
    return userData;
  }
}
