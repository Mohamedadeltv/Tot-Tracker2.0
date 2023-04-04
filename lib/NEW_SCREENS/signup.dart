import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tottracker/NEW_SCREENS/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:provider/provider.dart';
import 'package:tottracker/api/user_repositry.dart';
import 'package:tottracker/providers/signup_controller.dart';
import 'package:tottracker/providers/user.dart';
import '../NEW_WIDGETS/button.dart';
import '../NEW_WIDGETS/text_fieldvol2.dart';
import 'package:get/get.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final controller = Get.put(SignUpController());
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _genderController = TextEditingController();
  final _countryController = TextEditingController();
  String nameState = 'Enter Your Name';
  String email = 'Enter Your Email';
  String pass = 'Enter Your Password';
  String configPass = 'Confirm Password';
  String gender = 'Enter Your Gender';
  String country = 'Enter Your Country';
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _configpassFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          OutlinedButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _saveForm() async {
    //returns true lw kol el returns mel validator is null
    final is_valid = _form.currentState?.validate();
    if (!is_valid!) {
      setState(() {});
      return;
    }
    _form.currentState!.save();
    final user = User(
        name: controller.nameController.text.trim(),
        email: controller.emailController.text.trim(),
        password: controller.passwordController.text.trim(),
        country: controller.countryController.text.trim(),
        gender: controller.genderController.text.trim());
    SignUpController.instance.registerUser(user).then((value) =>
        SignUpController.instance.createUser(controller.emailController.text,
            controller.passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff3F3C3C),
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: 100,
              height: 100,
              child: Image.asset('assets/drawables/tottracker4.png'),
            ),
            Row(
              children: [
                Text(
                  '  Hello',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Color(0xff9a3a51),
                      fontFamily: 'Silom',
                      fontSize: 35,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '...!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Color(0xff1c69a2),
                      fontFamily: 'Silom',
                      fontSize: 35,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocusNode,
                        cursorColor: Color(0xff9a3a51),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 0.0,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff9a3a51),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                          hintText: nameState,
                          hintStyle: TextStyle(
                              color: nameState.startsWith('Please')
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        controller: controller.nameController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            nameState = 'Please Enter Your Name!';
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: TextFormField(
                        focusNode: _passFocusNode,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color(0xff1c69a2),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 0.0,
                          ),
                          prefixIcon: Icon(
                            Icons.email_sharp,
                            color: Color(0xff1c69a2),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                          hintText: email,
                          hintStyle: TextStyle(
                              color: email.startsWith('Please')
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        controller: controller.emailController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            email = 'Please Enter Your Email!';
                            return '';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value.toString();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        focusNode: _configpassFocusNode,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color(0xff9a3a51),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 0.0,
                          ),
                          prefixIcon: Icon(
                            Icons.password,
                            color: Color(0xff9a3a51),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                          hintText: pass,
                          hintStyle: TextStyle(
                              color: pass.startsWith('Please')
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        controller: controller.passwordController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            pass = 'Please Enter Your Password!';
                            return '';
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value.toString();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        focusNode: _genderFocusNode,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color(0xff1c69a2),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 0.0,
                          ),
                          prefixIcon: Icon(
                            Icons.confirmation_number,
                            color: Color(0xff1c69a2),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                          hintText: configPass,
                          hintStyle: TextStyle(
                              color: configPass.startsWith('Please')
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            configPass = 'Please Confirm Your Password!';
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: DropdownButton(
                        hint: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.male,
                                color: Color(0xff9a3a51),
                              ),
                              Text(
                                '   Please select your gender ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        underline: const SizedBox(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.all(
                            13,
                          ),
                          child: Icon(Icons.arrow_drop_down,
                              size: 25, color: Color.fromARGB(255, 90, 90, 90)),
                        ),
                        isExpanded: true,
                        items: [
                          "male",
                          "female",
                        ].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          controller.genderController.text = val!;
                          setState(() {
                            gender = val.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: DropdownButton(
                        hint: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.travel_explore,
                                color: Color(0xff1c69a2),
                              ),
                              Text(
                                '   Please select your country ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        underline: const SizedBox(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.all(
                            13,
                          ),
                          child: Icon(Icons.arrow_drop_down,
                              size: 25, color: Color.fromARGB(255, 90, 90, 90)),
                        ),
                        isExpanded: true,
                        items: [
                          "Egypt",
                          "USA",
                        ].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          controller.countryController.text = val!;
                          setState(() {
                            country = val.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MYB(
                text: "SIGN UP",
                text_color: Color.fromARGB(255, 210, 210, 205),
                ontap: _saveForm)
          ],
        ),
      ),
    );
  }
}
