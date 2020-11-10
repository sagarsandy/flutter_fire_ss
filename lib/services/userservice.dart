import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class UserService {
  storeNewUser(uid, email, context) {
    print('user service called');
    FirebaseFirestore.instance
        .collection('/users')
        .add({'email': email, 'uid': uid}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homescreen');
    }).catchError((error) {
      print(error);
    });
  }
}
