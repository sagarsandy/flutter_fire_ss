import 'package:flutter/material.dart';
import 'package:flutter_fire_ss/screens/homescreen.dart';
import 'package:flutter_fire_ss/screens/signinscreen.dart';
import 'package:flutter_fire_ss/screens/signupscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInScreen(),
      routes: <String, WidgetBuilder>{
        '/landingscreen': (BuildContext context) => MyApp(),
        '/signupscreen': (BuildContext context) => SignUpScreen(),
        '/homescreen': (BuildContext context) => HomeScreen()
      },
    );
  }
}
