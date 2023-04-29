import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BraceletsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Bracelets')
          .where('users', arrayContains: user?.email)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final bracelet = snapshot.data!.docs[index];
                final braceletData = bracelet.data() as Map<String, dynamic>;
                final braceletCode = braceletData['braceletCode'];
                final babyName = braceletData['babyName'];
                return Dismissible(
                  key: Key(braceletCode),
                  background: Container(
                    color: Theme.of(context).errorColor,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) {
                    return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text('are you sure'),
                              content: Text('do u wan to remove it?'),
                              actions: <Widget>[
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop(false);
                                  },
                                  child: Text('no'),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop(true);
                                  },
                                  child: Text('yes'),
                                ),
                              ],
                            ));
                  },
                  child: Card(
                      elevation: 9.0,
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 4,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 19.0,
                                  color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Baby Name: ',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: babyName,
                                  ),
                                ],
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Bracelet Code:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: braceletCode,
                                  ),
                                ],
                              ),
                            )),
                      )),
                  onDismissed: (direction) async {
                    final user = FirebaseAuth.instance.currentUser;

                    final braceletQuerySnapshot = await FirebaseFirestore
                        .instance
                        .collection('Bracelets')
                        .where('braceletCode', isEqualTo: braceletCode)
                        .get();
                    final braceletDoc =
                        braceletQuerySnapshot.docs.first.reference;

                    await FirebaseFirestore.instance
                        .collection('Bracelets')
                        .doc(braceletDoc.id)
                        .update({
                      'users': FieldValue.arrayRemove([user!.email])
                    });
                  },
                );
              },
            );
        }
      },
    );
  }
}
