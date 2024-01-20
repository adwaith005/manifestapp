import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:themanifestapp/Screens/landingpage.dart';
import 'package:themanifestapp/Screens/bottomnav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timetaking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'lib/images/logoin.png',
                height: 55,
                width: 202,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> Timetaking() async {
    await Future.delayed(const Duration(seconds: 5));

    // Store the context in a variable
    BuildContext? localContext = context;

    // Check if the user is already logged in
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If user is logged in, navigate to MyBottomNavigationBar
      Navigator.pushReplacement(
        localContext,
        MaterialPageRoute(builder: (localContext) => MyBottomNavigationBar()),
      );
    } else {
      // If user is not logged in, navigate to LandingPage
      Navigator.pushReplacement(
        localContext,
        MaterialPageRoute(builder: (localContext) => Landingpage()),
      );
    }
  }
}
