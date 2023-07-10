import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BabyCryingStreamBuilder extends StatefulWidget {
  @override
  State<BabyCryingStreamBuilder> createState() => _BabyCryingStreamBuilderState();
}

class _BabyCryingStreamBuilderState extends State<BabyCryingStreamBuilder> {
    DatabaseReference? databaseReference;

  @override
  void initState() {
    databaseReference = FirebaseDatabase.instance.reference();

    super.initState();
  }
void showPopup(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/drawables/tottracker4.png', // Replace with the path to your image
                      width: 100, // Adjust the width as needed
                      height: 100, // Adjust the height as needed
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Attention:Your baby is crying and needs your attention. Analyze the cause using our app\'s advanced feature for better care.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); 
                                                 databaseReference!
                  .child("Vitals/1-setFloat")
                  .update({"c": 0});// Close the dialog
                  },
                  child: Icon(
                    Icons.close_sharp,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          actions: [],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    return StreamBuilder<DataSnapshot>(
      stream: databaseReference
          .child("Vitals/1-setFloat")
          .onValue
          .map((event) => event.snapshot),
      builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for data, you can show a loading indicator or return null
          return Container();
        }
        if (snapshot.hasError) {
          // Handle any potential errors
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          DataSnapshot? dataSnapshot = snapshot.data;

          if (dataSnapshot != null) {
            Map<dynamic, dynamic>? values =
                dataSnapshot.value as Map<dynamic, dynamic>?;

            if (values != null) {
              // Check if the value of 'c' is equal to 1
              if (values["c"] == 1) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showPopup(context);
                });
              }
            }
          }
        }

        return Container();
      },
    );
  }

 
}
