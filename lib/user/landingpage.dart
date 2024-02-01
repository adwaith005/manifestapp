import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/user/login.dart';

class Landingpage extends StatelessWidget {
  const Landingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'lib/assets/logoin.png',
                  height: 40,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'Welcome to \n BROTOTYPE Manifest',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset('lib/assets/landingpagephoto.png'),
            Padding(
              padding: const EdgeInsets.only(left: 26,right: 20),
              child: Text(
                "Where we turn 'Are we there yet?' into 'We're almost there!' Get ready to track progress like a pro and turn milestones into smile-stones!",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: 338,
                height: 50,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF090B0B),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF090B0B),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
