import 'dart:async';

import 'package:chapter10/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'tab_page.dart';

class LoginPage extends StatelessWidget {
  //구글 로그인을 위한 객체
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //파이어 베이스 인증정보
  final FirebaseAuth _auth  = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Instagram Clone',
              style: GoogleFonts.pacifico(
                fontSize: 40.0,
              ),
            ),
            Container(
              margin: EdgeInsets.all(50.0),
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                _handleSingIn();
              },
            ),
          ],
        ),
      ),
    );
  }
 Future<FirebaseUser> _handleSingIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = (await _auth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken))).user;
    //로그인 정보를 출력하는 로그
   print("Signed In " + user.displayName);
   return user;
 }
}
