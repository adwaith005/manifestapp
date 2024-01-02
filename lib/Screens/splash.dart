import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:themanifestapp/Screens/bottomnav.dart';
import 'package:themanifestapp/Screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    timetaking();
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

Future<void> timetaking() async {
  await Hive.initFlutter();

  final Box<bool> box = await Hive.openBox<bool>('isLoggedIn');
  final bool? isLoggedIn = box.get('status', defaultValue: false);

  if (isLoggedIn ?? false) {
    // User is already logged in, navigate to the home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyBottomNavigationBar()),
    );
  } else {
    // User is not logged in, navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}



}
