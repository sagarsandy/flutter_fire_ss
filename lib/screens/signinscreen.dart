import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email;
  String password;
  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  registerWithPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:
          '+91 7981466038', // Test phone numbers need to add in firebase app
      timeout: Duration(seconds: 40),
      verificationCompleted: (PhoneAuthCredential credential) {
        FirebaseAuth.instance.signInWithCredential(credential).then((value) {
          print('auto detect');
          print(FirebaseAuth.instance.currentUser.uid);
          print(FirebaseAuth.instance.currentUser.phoneNumber);
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, int resendToken) {
        String smsCode = '123456'; // Test OTP need to add in firebase app
        // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: smsCode);
        //
        // // Sign the user in (or link) with the credential
        // FirebaseAuth.instance
        //     .signInWithCredential(phoneAuthCredential)
        //     .then((value) {
        //   print('Entered manually');
        //   print(FirebaseAuth.instance.currentUser.uid);
        //   print(FirebaseAuth.instance.currentUser.phoneNumber);
        // });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Timed out');
      },
    );
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    print(FirebaseAuth.instance.currentUser.uid);
    print(FirebaseAuth.instance.currentUser.email);
    Navigator.of(context).pushReplacementNamed('/homescreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Email"),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(hintText: "Password"),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text("Login"),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password)
                      .then((user) {
                    print(FirebaseAuth.instance.currentUser.uid);
                    print(FirebaseAuth.instance.currentUser.email);
                    Navigator.of(context).pushReplacementNamed('/homescreen');
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text("Login with Google"),
                color: Colors.cyan,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  signInWithGoogle();
                },
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text("Login with Phone Number"),
                color: Colors.yellowAccent,
                textColor: Colors.black,
                elevation: 7.0,
                onPressed: () {
                  registerWithPhoneNumber();
                },
              ),
              SizedBox(height: 15),
              Text("Don't have an account?"),
              SizedBox(height: 10),
              RaisedButton(
                child: Text("SignUp"),
                color: Colors.orange,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  Navigator.of(context).pushNamed('/signupscreen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
