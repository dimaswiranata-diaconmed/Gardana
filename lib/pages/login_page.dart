import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:gardana/scoped-models/main.dart';
import 'package:gardana/widget/ui_element/custom_button.dart';

class LoginPage extends StatefulWidget {
  final MainModel model;
  LoginPage(this.model);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final googleSignIn = GoogleSignIn();

  void _login() async {
    final user = await googleSignIn.signIn();
    if (user == null) {
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final userData = FirebaseAuth.instance.currentUser;
      print(userData.displayName);
      print(userData.email);
      print(userData.uid);
    }
  }

  Widget _buildPageContent() {
    return Stack(fit: StackFit.expand, children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LeanButton(
              child: Text('Masuk Dengan Google'),
              color: Colors.red,
              onPressed: _login,
            ),
            SizedBox(height: 16),
            LeanButton(
              child: Text('Masuk Dengan Facebook'),
              color: Colors.blue,
              onPressed: () {
                print('masuk dengan facebook');
              },
            )
          ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gardana'),
      ),
      body: _buildPageContent(),
    );
  }
}
