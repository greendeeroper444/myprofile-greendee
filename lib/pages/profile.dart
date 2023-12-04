import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myprofile_greendee/components/datalist.dart';
import 'package:myprofile_greendee/components/search.dart';
import 'package:myprofile_greendee/database/firestore.dart';
import 'package:myprofile_greendee/pages/addaccount.dart';

import '../auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final AuthService authService = AuthService();
  final TextEditingController searchController = TextEditingController();
  final FirestoreDatabase database = FirestoreDatabase();

  bool showPosts = false;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async{
    return await FirebaseFirestore
        .instance.collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.green.shade500,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot){
            //loading
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            //error
            else if(snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            }

            //data recieved
            else if (snapshot.hasData){
              //extract data
              Map<String, dynamic>? user = snapshot.data!.data();

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          child: authService.getProfileImage(),
                        ),
                      ),
                      Text("@${user!['username']}",
                        style: const TextStyle(fontSize: 25),
                      ),
                      Text(user['email'],
                      style: const TextStyle(
                          fontSize: 20)
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(thickness: 1.5, color: Colors.grey[500]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text('open the pocket', style: TextStyle(color: Colors.grey[700])),
                            ),
                            Expanded(
                              child: Divider(thickness: 1.5, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_downward),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green.shade500,
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(50, 50),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            showPosts = !showPosts;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/images/pocket.png',
                              height: 70,
                              width: 70,
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: showPosts,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SearchField(
                                      hintText: "Search your account",
                                      obscureText: false,
                                      controller: searchController,
                                    ),
                                  ),
                                  SearchButton(
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                'Account collection',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: Colors.green.shade800,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AddAccount()),
                                        );
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


                      //streambuilder
                      Visibility(
                        visible: showPosts,
                        child: SizedBox(
                          height: 200,
                          child: StreamBuilder(
                            stream: database.getPostsStream(),
                            builder: (context, snapshot){
                              //show loading
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              //get all posts
                              final posts = snapshot.data!.docs;

                              //no data?
                              if(snapshot.data == null || posts.isEmpty){
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(25),
                                    child: Text("No data, you can add your data!"),
                                  ),
                                );
                              }

                              // Filter posts for the current user
                              final currentUserEmail = database.user?.email;
                              final userPosts = posts.where((post) => post['UserEmail'] == currentUserEmail).toList();

                              if(userPosts.isEmpty){
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(25),
                                    child: Text("You have not posted anything yet."),
                                  ),
                                );
                              }

                              return ListView.builder(
                                  itemCount: userPosts.length,
                                  itemBuilder: (context, index){
                                    //get the individual posts
                                    final post = userPosts[index];

                                    //get data from each post
                                    String entryId = post.id;
                                    String account = post['PostAccount'];
                                    String password = post['PostPassword'];
                                    Timestamp timestamp = post['TimeStamp'];

                                    return DataList(
                                        account: account,
                                        password: password,
                                      entryId: entryId,
                                    );
                                  },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            else{
              return const Text("No data");
            }
          }
      ),
    );
  }
}