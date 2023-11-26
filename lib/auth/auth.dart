import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myprofile_greendee/auth/signin_or_signup.dart';

import '../pages/home.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //user is logged in
          if(snapshot.hasData){
            return const Home();
          }
          //user is not logged in
          else{
            return const SigninOrSignup();
          }
        },
      ),
    );
  }
}