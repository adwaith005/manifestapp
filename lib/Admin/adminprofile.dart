import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Screens/login.dart';

class Adminprofile extends StatefulWidget {
  const Adminprofile({Key? key});

  @override
  State<Adminprofile> createState() => _AdminprofileState();
}

class _AdminprofileState extends State<Adminprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B0B),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Logout button
          IconButton(
            onPressed: () {
              // Show confirmation dialog
              _showLogoutConfirmationDialog(context);
            },
            icon: const Icon(Icons.logout_outlined),
            color: Colors.red,
          ),
          Center(
            child: Image.asset(
              'lib/images/person.png', // Change this to the path of your image
              height: 180,
              width: 150,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Admin',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
