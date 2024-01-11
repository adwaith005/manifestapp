import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key, required Map<String, dynamic> userDetails}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? currentUser;

  @override
  void initState() {
    super.initState();
     final userBox = Hive.box<Map<String, dynamic>>('userDetails');
    currentUser = userBox.get('userDetails');
  }

  @override
  Widget build(BuildContext context) {
        String name = currentUser?['name'] ?? 'N/A';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Hello $name",
                  style: TextStyle(
                    fontSize: 24,
                    color: const Color(0xFF414141),
                    fontWeight: FontWeight.w900,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Container(
              width: 338,
              height: 76,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(1),
                border: Border.all(color: Colors.black),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                      text: "Your next Review date is\n",
                    ),
                    TextSpan(
                      text: "Thursday, 22 Dec 2023",
                      style: TextStyle(
                        color: Color(0xFF118900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 280,top: 18,left: 27),
            child: Text(
              "Your Reviews",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.inter().fontFamily,
              ),
            ),
          )
        ],
      ),
    );

  }

}
