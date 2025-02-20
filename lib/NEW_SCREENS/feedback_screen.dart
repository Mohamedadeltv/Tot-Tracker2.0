import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import '../custom_drawer/app_theme.dart';
import 'package:flutter/material.dart';

import 'message.dart';

class FeedbackScreen extends StatefulWidget {
  static const routeName = '/feedback';
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _sendFeedback(String feedback) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final CollectionReference feedbackRef =
          FirebaseFirestore.instance.collection('Feedbacks');

      // Add the feedback to the "Feedbacks" collection
      final feedbackDocRef = await feedbackRef.add({
        'user email': user!.email,
        'feedback': feedback,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Get the user's document reference
      final userQuerySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: user!.email)
          .get();
      final userDoc = userQuerySnapshot.docs.first.reference;
      await userDoc.set({
        'feedbacks': FieldValue.arrayUnion([feedbackDocRef]),
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Feedback sent successfully!'),
        duration: Duration(seconds: 2),
      ));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeaturesOverviewScreen(),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to send feedback!'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the previous page
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor:
            isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
        body: SafeArea(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/drawables/tottracker4.png',
                        )),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      Container(width: 230,height: 230,child: Image.asset('assets/drawables/feedbackImage.png')),
                      SizedBox(height: 8),
                      Text(
                        'Your Feedback',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isLightMode ? Colors.black : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),BabyCryingStreamBuilder(),
                      Text(
                        'Give your best time for this moment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: isLightMode ? Colors.black : Colors.white,
                        ),
                      ),
                      _buildComposer(),
                      SizedBox(height: 16),
                      Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isLightMode ? Colors.blue : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                _sendFeedback(_textEditingController.text);
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Send',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: isLightMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              offset: const Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your feedback...',
                  contentPadding: const EdgeInsets.only(left: 16, bottom: 12),
                ),
                maxLines: null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
