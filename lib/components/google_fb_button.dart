import 'package:flutter/material.dart';

class GoogleAndFacebook extends StatelessWidget {

  final String imagePath;
  final String title;
  final Function()? onTap;
  final VoidCallback onPressed;

  const GoogleAndFacebook({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 30,
            ),
            const SizedBox(width: 10),
            Text(
              '$title',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}






