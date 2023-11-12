import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myprofile_greendee/auth/auth.dart';
import 'package:myprofile_greendee/pages/home.dart';
import 'package:myprofile_greendee/pages/profile.dart';
import 'package:myprofile_greendee/pages/signin.dart';

import 'auth/signin_or_signup.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Auth(),
      routes: {
        '/signin_signup_page':(context) => const SigninOrSignup(),
        '/home_page':(context) => Home(),
        // '/profile_page':(context) => ProfilePage(),
      },
    );
  }
}