import 'package:flutter/material.dart';
import 'package:themanifestapp/user/login.dart';

void performLogout(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}
