import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../components/textfield.dart';
import '../database/firestore.dart';

class AddAccount extends StatefulWidget {
  AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final TextEditingController newPostController = TextEditingController();

  final TextEditingController postPasswordController = TextEditingController();

  final FirestoreDatabase database = FirestoreDatabase();

  void SaveData() {

    if (newPostController.text.isNotEmpty && postPasswordController.text.isNotEmpty) {
      String account = newPostController.text;
      String password = postPasswordController.text;
      database.addPost(account, password);

      Fluttertoast.showToast(
        msg: "Data created successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.shade800,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    // Clear the controllers
    newPostController.clear();
    postPasswordController.clear();
  }

  bool _isObscure = true;
 // Initial state for password visibility
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Account"),
        backgroundColor: Colors.green.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyTextField(
              hintText: "Account",
              obscureText: false,
              controller: newPostController,
            ),

            const SizedBox(height: 10),

            // Text field for the password
            _buildPasswordTextField(),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: SaveData,
              style: ElevatedButton.styleFrom(
                primary: Colors.green.shade600,
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return MyTextField(
      hintText: "Password",
      obscureText: _isObscure,
      controller: postPasswordController,
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
    );
  }
}
