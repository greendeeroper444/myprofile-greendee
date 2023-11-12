import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/drawer.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.green.shade500,
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoURL ?? 'https://lh3.googleusercontent.com/a/ACg8ocIoN0yfaVVEfLUCDsvBymHd2XsJjmstwocot3rSUylo=s96-c'),
            ),
            SizedBox(height: 16),
            Text(
              "Logged in as:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              user.email!,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
