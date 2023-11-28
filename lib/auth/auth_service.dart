import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserCredential?> signInWithGoogle() async {
  try {
    await GoogleSignIn().signOut();

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser == null){
      showToast("Sign in canceled by user");
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = authResult.user;

    //Check if the identifier or UID is available
    if(user == null || user.email == null){
      showToast("Invalid user or identifier not found");
      await FirebaseAuth.instance.signOut();
      return null;
    }

    final userFirestore = await FirebaseFirestore.instance.collection('Users').doc(user.email).get();

    //Check if the user exists in Firestore
    if(!userFirestore.exists){
      showToast("You are not registered. Register first and try again!");
      await FirebaseAuth.instance.signOut();
      return null;
    }

    return authResult;
  } catch (e) {
    print("Error signing in with Google: $e");
    showToast("Sign in failed");
    return null;
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Widget getProfileImage() {
    if (_firebaseAuth.currentUser?.photoURL != null) {
      return ClipOval(
        child: Image.network(
          _firebaseAuth.currentUser!.photoURL!,
          height: 100,
          width: 100,
        ),
      );
    } else {
      return const ClipOval(
        child: Icon(Icons.account_circle, size: 100),
      );
    }
  }
}



