import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tottracker/NEW_SCREENS/main_screen.dart';

class ForgetPasswordSreen extends StatefulWidget {
  const ForgetPasswordSreen({super.key});
  static const routeName = '/forget';

  @override
  State<ForgetPasswordSreen> createState() => _ForgetPasswordSreenState();
}

class _ForgetPasswordSreenState extends State<ForgetPasswordSreen> {
  TextEditingController forgetpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 212, 207, 207),
            ),
            child: Material(
              child: TextFormField(
                cursorColor: Color(0xff9a3a51),
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontSize: 0.0,
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xff9a3a51),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 15, top: 15, right: 15),
                  hintText: 'Email',
                ),
                controller: forgetpass,
              ),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              var forgetEmail = forgetpass.text.trim();
              try {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: forgetEmail)
                    .then((value) => print('email sent'))
                    .then((value) => Get.snackbar(
                        "", " Email Sent",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black54,
                        colorText: Colors.white));
                Get.off(() => MainScreen());
              } on FirebaseAuthException catch (e) {
                print("Error $e");
              }
            },
            child: Text("Forget Password"))
      ]),
    );
  }
}
