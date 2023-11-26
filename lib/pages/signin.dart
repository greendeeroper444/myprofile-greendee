import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myprofile_greendee/auth/auth_service.dart';

import '../components/button.dart';
import '../components/google_fb_button.dart';
import '../components/textfield.dart';
import '../helper/helper_function.dart';

class Signin extends StatefulWidget {
  final void Function()? onTap;

 const Signin({super.key,
    required this.onTap
  });

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  //text controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //signin method
  void signinUser () async{
    //show laoding circle
    showDialog(context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ));

    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);

      //pop loading circle
      if(context.mounted) Navigator.pop(context);
    }
    //display any errors
    on FirebaseAuthException catch (e){
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  bool _isObscure = true;

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
                style: TextStyle(fontSize: 20,
                  color: Colors.green.shade900
                ),
              ),

              const SizedBox(height: 20),
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
                obscureText: _isObscure,
                controller: passwordController,
                suffixIcon: IconButton(
                  icon: _isObscure
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
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
              //Sign in button
              MyButton(
                text: "Sign in",
                onTap: signinUser,
              ),
              const SizedBox(height: 20),

              //or conti with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[500]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('or', style: TextStyle(color: Colors.grey[700])),
                    ),
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //gGoogle
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google button
                  GoogleAndFacebook(
                    onTap: () => signInWithGoogle(),
                    imagePath: 'lib/images/google.png',
                    title: 'Sign in with Google',
                  ),
                  const SizedBox(height: 10),
                  // Facebook button
                  GoogleAndFacebook(
                    onTap: () {},
                    imagePath: 'lib/images/facebook.png',
                    title: 'Sign in with Facebook',
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              //Dont have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                    style: TextStyle(
                        color: Colors.grey.shade600
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Sign up here",
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