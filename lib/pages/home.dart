import 'package:flutter/material.dart';
import '../components/drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("G R E E N D E E  W O R L D"),
        backgroundColor: Colors.green.shade500,
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Welcome to Greendee World!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                'You can visit your profile and enjoy its pocket',
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade800,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Image.asset(
                'lib/images/greendee.png',
                height: 100,
                width: 100,
              ),
            ),

            const SizedBox(height: 20),

            _buildExploreButton(context),
          ],
        ),
      ),
    );
  }


  Widget _buildExploreButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.green.shade900),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: Colors.grey, width: 2.0),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
        child: const Text(
          'Explore Now',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}