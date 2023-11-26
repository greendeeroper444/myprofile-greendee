import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/textfield.dart';
import '../helper/helper_function.dart';

class Signup extends StatefulWidget {
  final void Function()? onTap;

  const Signup({super.key,
    required this.onTap
  });

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void signupUser() async{
    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )
    );

    if(passwordController.text != confirmController.text){
      Navigator.pop(context);
      displayMessageToUser("Password don't match", context);
    }
    else{
      try{

        UserCredential? userCredential = await
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );

        //create user document and add to firestore
        createUserDocument(userCredential);

        if(context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

  //create user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async{
    if(userCredential != null && userCredential.user != null){
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo
              Image.asset(
                'lib/images/greendee.png',
                width: 100,
                height: 100,
              ),

              const SizedBox(height: 20),

              //App name
              Text("G R E E N D E E W O R L D",
                style: TextStyle(
                  fontSize: 20,
                  color:  Colors.green.shade900
                ),
              ),

              const SizedBox(height: 20),
              //username
              MyTextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController
              ),
              const SizedBox(height: 10),
              //Email
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController
              ),
              const SizedBox(height: 10),
              //Password
              MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController
              ),
              const SizedBox(height: 10),
              //Confirm Password
              MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmController
              ),
              const SizedBox(height: 10),

              //Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password?",
                    style: TextStyle(
                        color: Colors.grey.shade800
                    ),)
                ],
              ),
              const SizedBox(height: 20),
              //Sign up button
              MyButton(
                text: "Sign up",
                onTap: signupUser,
              ),
              const SizedBox(height: 20),
              //Dont have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",
                    style: TextStyle(
                        color: Colors.grey.shade600
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Sign in here",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                        color: Colors.green.shade700
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}