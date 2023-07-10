import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../NEW_WIDGETS/button.dart';

class BraceletForm extends StatefulWidget {
  final Function() toggle;
  BraceletForm(this.toggle);
  @override
  _BraceletFormState createState() => _BraceletFormState();
}

class _BraceletFormState extends State<BraceletForm> {
  final _formKey = GlobalKey<FormState>();
  late String _braceletCode;
  late String _babyName;
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      final user = FirebaseAuth.instance.currentUser;
      final userQuerySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: user!.email)
          .get();

// Check if there are any documents in the query snapshot
      if (userQuerySnapshot.docs.isNotEmpty) {
        final userDoc = userQuerySnapshot.docs.first.reference;
        final braceletQuerySnapshot = await FirebaseFirestore.instance
            .collection('Bracelets')
            .where('braceletCode', isEqualTo: _braceletCode)
            .get();

        // Check if there are any documents in the query snapshot
        if (braceletQuerySnapshot.docs.isNotEmpty) {
          // If the bracelet code already exists, update the users field
          final braceletDoc = braceletQuerySnapshot.docs.first.reference;
          await braceletDoc.update({
            'users': FieldValue.arrayUnion([user!.email]),
          });
          final braceletRef = FirebaseFirestore.instance
              .collection('Bracelets')
              .doc(braceletDoc.id);
          await userDoc.set({
            'Bracelets': FieldValue.arrayUnion([braceletRef]),
          }, SetOptions(merge: true));
        } else {
          // If the bracelet code doesn't exist, add a new document to the Bracelets collection
          final now = DateTime.now();
          await FirebaseFirestore.instance.collection('Bracelets').add({
            'braceletCode': _braceletCode,
            'babyName': _babyName,
            'users': [user!.email],
            'timestamp': now,
          }).then((braceletRef) async {
            await userDoc.set({
              'Bracelets': FieldValue.arrayUnion([braceletRef]),
            }, SetOptions(merge: true));
          });
        }
      } else {
        print('No user found with email: ${user.email}');
      }
      widget.toggle();
      // Clear the form after submitting it
      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Bracelet Code',
                  labelStyle: TextStyle(
                    color: Color(0xff1c69a2),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 7, 56, 94),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter a bracelet code';
                  }
                  return null;
                },
                onSaved: (value) {
                  _braceletCode = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Baby Name',
                  labelStyle: TextStyle(
                    color: Color(0xff9a3a51),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff9a3a51),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter the baby name';
                  }
                  return null;
                },
                onSaved: (value) {
                  String? stringValue = value.toString();
                  _babyName = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Baby Username',
                  labelStyle: TextStyle(
                    color: Color(0xff9a3a51),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff9a3a51),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter the baby name';
                  }
                  return null;
                },
                onSaved: (value) {
                  String x = value!;
                },
              ),
              SizedBox(height: 10),
              Center(
                child: MYB(
                  text: 'Add Bracelet',
                  ontap: _submitForm,
                  text_color: Color.fromARGB(255, 210, 210, 205),
                  size: 250.0,
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
