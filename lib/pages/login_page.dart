import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:gardana/scoped-models/main.dart';
import 'package:gardana/widget/ui_element/custom_button.dart';

class LoginPage extends StatefulWidget {
  final MainModel model;
  LoginPage(this.model);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _googleSignIn = GoogleSignIn();

  Future<void> _loginFacebook() async {
    try {
      final AccessToken result = await FacebookAuth.instance.login();
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.token);

      final userFromFB = (await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential))
          .user;
      print(userFromFB);
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      print(userData);
    } on FacebookAuthException catch (e) {
      // if the facebook login fails
      print(e.message); // print the error message in console
      // check the error type
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
    }
  }

  void _loginGoogle() async {
    final user = await _googleSignIn.signIn();
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
              onPressed: _loginGoogle,
            ),
            SizedBox(height: 16),
            LeanButton(
              child: Text('Masuk Dengan Facebook'),
              color: Colors.blue,
              onPressed: _loginFacebook,
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
