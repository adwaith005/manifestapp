import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:themanifestapp/Screens/login.dart';

void performLogout(BuildContext context) {
  Hive.box<bool>('isLoggedIn').put('status', false);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}
