import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BraceletsList extends StatefulWidget {
  @override
  State<BraceletsList> createState() => _BraceletsListState();
}

class _BraceletsListState extends State<BraceletsList> {
  final user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final query1=FirebaseFirestore.instance
                  .collection('Bracelets')
                  .where('users', arrayContains: user?.email)
                  .orderBy('timestamp', descending: true)
                  .snapshots();
    return Column(
      children: [
     

        Flexible(
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
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
                    if (snapshot.data!.docs.length == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              'assets/drawables/Free vector icon_ Download thousands of free icons of electronics in SVG, PSD, PNG, EPS format or as ICON FONT.png',
                              height: 210),
                          SizedBox(height: 16),
                          Text(
                            'No bracelets added yet!',
                            style: TextStyle(
                                fontSize: 35,
                                color: Color.fromARGB(255, 88, 3, 131),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final bracelet = snapshot.data!.docs[index];
                          final braceletData =
                              bracelet.data() as Map<String, dynamic>;
                          final braceletCode = braceletData['braceletCode'];
                          var babyName = braceletData['babyName'];
                          return Dismissible(
                            key: Key(braceletCode),
                            background: Container(
                              color: Colors.green,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.keyboard_double_arrow_right_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.only(left: 20),
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 4,
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Theme.of(context).errorColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.keyboard_double_arrow_left_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.only(right: 20),
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 4,
                              ),
                            ),
                            direction: DismissDirection.horizontal,
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                return showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Delete Bracelet'),
                                    content: Text(
                                        'Are you sure you want to delete this bracelet?'),
                                    actions: <Widget>[
                                      OutlinedButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(false),
                                        child: Text('No'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(true),
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                final textController = TextEditingController();
                                String newBabyName = babyName;

                                await showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Edit Baby Name'),
                                    content: TextField(
                                      controller: textController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter new baby name',
                                      ),
                                      onChanged: (value) => newBabyName = value,
                                    ),
                                    actions: <Widget>[
                                      OutlinedButton(
                                        onPressed: () => Navigator.of(ctx).pop(),
                                        child: Text('Cancel'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () async {
                                          final user =
                                              FirebaseAuth.instance.currentUser;
                                          final braceletQuerySnapshot =
                                              await FirebaseFirestore.instance
                                                  .collection('Bracelets')
                                                  .where('braceletCode',
                                                      isEqualTo: braceletCode)
                                                  .get();
                                          final braceletDoc =
                                              braceletQuerySnapshot
                                                  .docs.first.reference;

                                          await FirebaseFirestore.instance
                                              .collection('Bracelets')
                                              .doc(braceletDoc.id)
                                              .update({
                                            'babyName': newBabyName,
                                          });
                                          setState(() {
                                            babyName = newBabyName;
                                          });
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text('Save'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Card(
                                elevation: 9.0,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 0,
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
                              if (direction == DismissDirection.endToStart) {
                                // swiped from right to left
                                final user = FirebaseAuth.instance.currentUser;
                                final braceletQuerySnapshot =
                                    await FirebaseFirestore.instance
                                        .collection('Bracelets')
                                        .where('braceletCode',
                                            isEqualTo: braceletCode)
                                        .get();
                                final braceletDoc =
                                    braceletQuerySnapshot.docs.first.reference;
                                await FirebaseFirestore.instance
                                    .collection('Bracelets')
                                    .doc(braceletDoc.id)
                                    .update({
                                  'users': FieldValue.arrayRemove([user!.email])
                                });
                              } else if (direction ==
                                  DismissDirection.startToEnd) {}
                            },
                          );
                        },
                      );
                    }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
