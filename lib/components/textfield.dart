import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;

  const MyTextField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 3,
            color: Colors.green.shade700
          )
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
    );
  }
}