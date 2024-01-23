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
    BuildContext? localContext = context;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        localContext,
        MaterialPageRoute(builder: (localContext) => MyBottomNavigationBar()),
      );
    } else {
      Navigator.pushReplacement(
        localContext,
        MaterialPageRoute(builder: (localContext) => Landingpage()),
      );
    }
  }
}
