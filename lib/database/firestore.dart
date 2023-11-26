import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // Current logged-in user
  User? user = FirebaseAuth.instance.currentUser;

  // Get collection of posts from Firebase
  final CollectionReference posts = FirebaseFirestore.instance.collection('Posts');

  // Post message
  Future<void> addPost(String account, password) {
    return posts.add({
      'PostPassword': password,
      'PostAccount': account,
      'TimeStamp': Timestamp.now(),
      'UserEmail': user?.email,
    });
  }

  Future<void> updatePost(String oldAccount, String newAccount, String newPassword) async {
    try {
      // Assuming 'PostAccount' is the field used as the document ID
      final QuerySnapshot querySnapshot = await posts.where('PostAccount', isEqualTo: oldAccount).get();
      final List<DocumentSnapshot> documents = querySnapshot.docs;

      if (documents.isNotEmpty) {
        final String documentId = documents[0].id;
        await posts.doc(documentId).update({
          'PostAccount': newAccount,
          'PostPassword': newPassword,
        });
      } else {
        print("No document found with account: $oldAccount");
      }
    } catch (e) {
      print("Error updating post: $e");
    }
  }

  // Read posts from the database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();

    return postsStream;
  }
}

