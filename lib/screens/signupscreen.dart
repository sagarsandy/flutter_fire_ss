import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fire_ss/services/userservice.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email;
  String password;

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
                child: Text("Sign Up"),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  print('signup clicked');
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((UserCredential user) {
                    print('signup success');
                    print(FirebaseAuth.instance.currentUser.uid);
                    print(FirebaseAuth.instance.currentUser.email);
//                    Navigator.of(context).pop();
//                    Navigator.of(context).pushReplacementNamed('/homescreen');
                    UserService().storeNewUser(
                        FirebaseAuth.instance.currentUser.uid,
                        FirebaseAuth.instance.currentUser.email,
                        context);
                  }).catchError((error) {
                    print(error);
                  });
                },
              ),
              SizedBox(height: 15),
              Text("Already have an account?"),
              SizedBox(height: 10),
              RaisedButton(
                child: Text("SignIn"),
                color: Colors.orange,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
