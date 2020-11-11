import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/MainScreen/main_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
// import 'package:flutter_auth/Screens/MainScreen/components/main_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  get googleSignIn => null;

  get firebaseAuth => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return mainScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: () async {
                final GoogleSignInAccount googleUser = await googleSignIn.signIn();
                final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;

                final AuthCredential credential = GoogleAuthProvider.getCredential(
                    idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

                final FirebaseUser user =
                    (await firebaseAuth.signInWithCredential(credential)).user;
              },
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.google),
                  SizedBox(width: 10),
                  Text('Sign-in using Google',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              textColor: Colors.white,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

