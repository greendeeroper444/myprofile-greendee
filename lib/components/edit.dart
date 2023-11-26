import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myprofile_greendee/components/textfield.dart';

import '../database/firestore.dart';

class EditModal extends StatefulWidget {
  final String account;
  final String password;

  const EditModal({
    Key? key,
    required this.account,
    required this.password,
  }) : super(key: key);

  @override
  _EditModalState createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> {
  TextEditingController newAccountController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final FirestoreDatabase database = FirestoreDatabase();

  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    newAccountController.text = widget.account;
    newPasswordController.text = widget.password;
  }

  void saveData() async{
    if (newAccountController.text.isNotEmpty && newPasswordController.text.isNotEmpty) {
      String updatedAccount = newAccountController.text;
      String updatedPassword = newPasswordController.text;

      await database.updatePost(widget.account, updatedAccount, updatedPassword);

      Fluttertoast.showToast(
        msg: "Data updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.shade800,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [

          const SizedBox(height: 10),

          MyTextField(
            hintText: "Account",
            obscureText: false,
            controller: newAccountController,
          ),

          const SizedBox(height: 10),

          _buildPasswordTextField(),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: saveData,
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
    );
  }

  Widget _buildPasswordTextField() {
    return MyTextField(
      hintText: "Password",
      obscureText: _isObscure,
      controller: newPasswordController,
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
