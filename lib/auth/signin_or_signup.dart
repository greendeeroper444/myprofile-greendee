import 'package:flutter/material.dart';

import '../pages/signin.dart';
import '../pages/signup.dart';


class SigninOrSignup extends StatefulWidget {
  const SigninOrSignup({super.key});

  @override
  State<SigninOrSignup> createState() => _SigninOrSignupState();
}

class _SigninOrSignupState extends State<SigninOrSignup> {

  //initially, show signin page
  bool showSignin = true;

  //toggle between signin and signup page
  void togglePages(){
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return Signin(onTap: togglePages);
    } else{
      return Signup(onTap: togglePages);
    }
  }
}