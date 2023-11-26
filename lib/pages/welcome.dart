import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key});

  void navigateToAuthPage(BuildContext context) {
    Navigator.pushNamed(context, '/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'lib/images/greendee.png',
                width: 100,
                height: 100,
              ),

              const SizedBox(height: 20),

              // App name
              Text(
                "G R E E N D E E W O R L D",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green.shade900,
                ),
              ),

              const SizedBox(height: 20),

              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.white;
                        }
                        return Colors.green;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.green;
                        }
                        return Colors.white;
                      },
                    ),
                  ),
                  onPressed: () {
                    navigateToAuthPage(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Continue to explore",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.arrow_right),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
