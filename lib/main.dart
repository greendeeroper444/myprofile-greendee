import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myprofile_greendee/auth/auth.dart';
import 'package:myprofile_greendee/pages/home.dart';
import 'package:myprofile_greendee/pages/profile.dart';
import 'package:myprofile_greendee/pages/welcome.dart';

import 'auth/signin_or_signup.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      routes: {
        '/signin_signup': (context) => const SigninOrSignup(),
        '/home': (context) => const Home(),
        '/profile':(context) => ProfilePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/auth') {
          return MaterialPageRoute(
            builder: (context) => const Auth(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
