// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ProfilePage extends StatelessWidget {
//   ProfilePage({super.key});
//
//   //current logged in user
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//
//   //fuutre to fetch user details
//   Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async{
//     return await FirebaseFirestore
//         .instance.collection("Users")
//         .doc(currentUser!.email)
//         .get();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile"),
//         backgroundColor: Colors.green.shade500,
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//           future: getUserDetails(),
//           builder: (context, snapshot){
//             //loading
//             if(snapshot.connectionState == ConnectionState.waiting){
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//
//             //error
//             else if(snapshot.hasError){
//               return Text("Error: ${snapshot.error}");
//             }
//
//             //data recieved
//             else if (snapshot.hasData){
//               //extract data
//               Map<String, dynamic>? user = snapshot.data!.data();
//
//               return Center(
//                 child: Column(
//                   children: [
//                     Text(user!['email']),
//                     Text(user['username'])
//                   ],
//                 ),
//               );
//             }
//             else{
//               return Text("No data");
//             }
//           }
//       ),
//     );
//   }
// }