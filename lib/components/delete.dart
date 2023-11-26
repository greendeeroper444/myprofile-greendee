import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteButton extends StatefulWidget {
  final String entryId;
  const DeleteButton({super.key, required this.entryId});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  Future<void> deleteEntry(BuildContext context) async {
    try {

      DocumentReference documentReference =
      FirebaseFirestore.instance.collection('Posts').doc(widget.entryId);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this entry?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await documentReference.delete();

                  // Show success message
                  Fluttertoast.showToast(
                    msg: 'Data deleted successfully!',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green.shade800,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );

                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle errors
      print('Error deleting entry: $e');
      Fluttertoast.showToast(
        msg: 'Error deleting entry: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () => deleteEntry(context),
    );
  }
}

