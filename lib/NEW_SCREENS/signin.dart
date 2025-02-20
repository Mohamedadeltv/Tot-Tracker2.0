import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/forget_password_screen.dart';
import 'package:tottracker/api/auth_repositry.dart';
import '../NEW_WIDGETS/button.dart';

class signin extends StatefulWidget {
  final Function() toggle;
  signin(this.toggle);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final _form = GlobalKey<FormState>();
  String email = 'Enter Your Email';
  String pass = 'Enter Your Password';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passFocusNode = FocusNode();

  var _isLoading = false;
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
    setState(() {
      _isLoading = true;
    });
    AuthenticationRepositry.instance.signInWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    // try {
    //   // await Provider.of<Auth>(context, listen: false).login(
    //   //   _authData['email'].toString(),
    //   //   _authData['password'].toString(),
    //   // );
    // } on HttpException catch (error) {
    //   var errorMessage = 'Authentication failed';
    //   if (error.toString().contains('EMAIL_EXISTS')) {
    //     errorMessage = 'This email address is already in use.';
    //   } else if (error.toString().contains('INVALID_EMAIL')) {
    //     errorMessage = 'This is not a valid email address';
    //   } else if (error.toString().contains('WEAK_PASSWORD')) {
    //     errorMessage = 'This password is too weak.';
    //   } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
    //     errorMessage = 'Could not find a user with that email.';
    //   } else if (error.toString().contains('INVALID_PASSWORD')) {
    //     errorMessage = 'Invalid password.';
    //   }
    //   _showErrorDialog(errorMessage);
    // } catch (error) {
    //   const errorMessage =
    //       'Could not authenticate you. Please try again later.';
    //   _showErrorDialog(errorMessage);
    // }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      //backgroundColor: Color(0xff3F3C3C),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: 950,
              height: 200,
              child: Image.asset('assets/drawables/tottracker4.png'),
            ),
            SizedBox(
              width: double.infinity,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Welcome',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xff1c69a2),
                          fontFamily: 'Silom',
                          fontSize: 35,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Back',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Color(0xff9a3a51),
                          fontFamily: 'Silom',
                          fontSize: 35,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 212, 207, 207),
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: _passFocusNode,
                          cursorColor: Color(0xff1c69a2),
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: 0.0,
                            ),
                            prefixIcon: Icon(
                              Icons.person,
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
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              email = 'Please Enter Your Name!';
                              return '';
                            }
                            return null;
                          },
                          controller: _emailController,
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
                          textInputAction: TextInputAction.next,
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
                            hintText: pass,
                            hintStyle: TextStyle(
                                color: pass.startsWith('Please')
                                    ? Colors.red
                                    : Colors.black54),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              pass = 'Please Enter Your Name!';
                              return '';
                            }
                            return null;
                          },
                          controller: _passwordController,
                        ),
                      ),
                    ),
                  ],
                )),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ForgetPasswordSreen.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forget',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xff9a3a51),
                        fontFamily: 'Silom',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    ' Your',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xff1c69a2),
                        fontFamily: 'Silom',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    ' Password ?',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Color(0xff9a3a51),
                        fontFamily: 'Silom',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(27.0),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : MYB(
                      text: "LOGIN",
                      text_color: Color.fromARGB(255, 210, 210, 205),
                      ontap: _saveForm,size: 157.0,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New User ?',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Color(0xff9a3a51),
                      fontFamily: 'Silom',
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {
                    widget.toggle();
                  },
                  child: Text(
                    ' Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff1c69a2),
                        fontFamily: 'Silom',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
