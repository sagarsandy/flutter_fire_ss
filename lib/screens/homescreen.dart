import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome..."),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You are now logged in"),
              SizedBox(height: 15),
              OutlineButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.of(context)
                        .pushReplacementNamed('/landingscreen');
                  }).catchError((e) {
                    print(e);
                  });
                },
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 4.0),
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
