import 'package:flutter/material.dart';
import '../api/auth_repositry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LinkAccountsWidget extends StatefulWidget {
  const LinkAccountsWidget({Key? key}) : super(key: key);

  @override
  _LinkAccountsWidgetState createState() => _LinkAccountsWidgetState();
}

class _LinkAccountsWidgetState extends State<LinkAccountsWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _linkAccountController = TextEditingController();

  bool _linkAccounts = false;

  @override
  void dispose() {
    _emailController.dispose();
    _linkAccountController.dispose();
    super.dispose();
  }

  void _onLinkAccountsChanged(bool? value) {
    setState(() {
      _linkAccounts = value!;
    });
  }

  Future<void> _onSubmit() async {
    final email = _emailController.text.trim();
    final linkAccount = _linkAccountController.text.trim();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Use the user object here
      print('USADBASDHJASBVDHSAVDGHSAVDGSVAGS');
      print(user.email);
      String? password;

      try {
        var querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: linkAccount)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var data = querySnapshot.docs.first.data();
          password = data['password'];
        }
      } catch (e) {
        print('Error fetching password: $e');
      }

      print(password);
      // Do something with the email and linkAccount
      if (_linkAccounts) {
        print('objectAAAAAAaAAAAaaAAA');
        AuthenticationRepositry.instance
            .createUserWithEmailAndPasswordandLinkAccount(
                email, password!, linkAccount);

        // Link accounts logic here
      } else {
        // Do something else
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Accounts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your email:',
              style: TextStyle(fontSize: 16.0),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'you@example.com',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Link to another account?',
              style: TextStyle(fontSize: 16.0),
            ),
            Row(
              children: [
                Checkbox(
                  value: _linkAccounts,
                  onChanged: _onLinkAccountsChanged,
                ),
                const Text(
                  'Yes, link my account to:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Expanded(
                  child: TextField(
                    controller: _linkAccountController,
                    enabled: _linkAccounts,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'partner@example.com',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _onSubmit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
