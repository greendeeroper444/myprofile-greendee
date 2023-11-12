import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //signout user
  void signoutUser(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //drawer header
              DrawerHeader(
                child: Icon(
                    Icons.favorite
                ),
              ),

              const SizedBox(height: 20),

              //home tile
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                      Icons.home
                  ),
                  title: Text("H O M E"),
                  onTap: () {
                    //this is already the home screen so just pop drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              //profile
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                      Icons.person
                  ),
                  title: const Text("P R O F I L E"),
                  onTap: () {
                    //this is already the home screen so just pop drawer
                    Navigator.pop(context);

                    //navigate to profile page
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),
            ],
          ),
          //signout
          Padding(
            padding: EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: Icon(
                  Icons.logout
              ),
              title: const Text("S I G N O U T"),
              onTap: () {
                //this is already the home screen so just pop drawer
                Navigator.pop(context);

                //signout
                signoutUser();
              },
            ),
          )
        ],
      ),
    );
  }
}