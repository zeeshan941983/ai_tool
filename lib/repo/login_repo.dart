import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wezee_tool/components/color.dart';

class Loginrepo {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> loginUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacementNamed(context, 'home');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Fluttertoast.showToast(
            msg: "User Not Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.mainorange,
            textColor: AppColors.mainWhite,
            fontSize: 16.0);
      } else if (e.code == 'wrong password') {
        Fluttertoast.showToast(
            msg: e.code,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.mainorange,
            textColor: AppColors.mainWhite,
            fontSize: 16.0);
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: e.code,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.mainorange,
            textColor: AppColors.mainWhite,
            fontSize: 16.0);
      }
      return null;
    }
  }

  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Fluttertoast.showToast(
          msg: "User is Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.mainpurple,
          textColor: AppColors.mainWhite,
          fontSize: 16.0);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.code,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.mainorange,
          textColor: AppColors.mainWhite,
          fontSize: 16.0);
    }
    return null;
  }

  // Future<void> signInWithApple(BuildContext context) async {
  //   try {
  //     final FirebaseAuth _auth = FirebaseAuth.instance;

  //     // Create a new AppleAuthProvider instance
  //     final OAuthProvider appleProvider = OAuthProvider('apple.com');

  //     // Sign in the user with Firebase
  //     final UserCredential userCredential =
  //         await _auth.signInWithPopup(appleProvider);

  //     // Navigate to home screen or perform other actions after successful login
  //     Navigator.pushReplacementNamed(context, 'home');
  //   } catch (e) {
  //     print('Error signing in with Apple: $e');
  //     // Handle errors here
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Sign In Error'),
  //           content: Text('An error occurred while signing in with Apple.'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
}
