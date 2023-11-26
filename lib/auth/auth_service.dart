import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  try {

    await GoogleSignIn().signOut();

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {

      return Future.error("Sign in canceled by user");
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    print("Error signing in with Google: $e");
    return Future.error("Sign in failed");
  }
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



