import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String domain = '';
  String batch = '';
  String email = '';
  String phoneNo = '';

  @override
  void initState() {
    super.initState();
    fetchStudentData(widget.uid);
  }

  Future<void> fetchStudentData(String uid) async {
    try {
      var studentRef = FirebaseFirestore.instance.collection('students');
      var docSnapshot = await studentRef.doc(uid).get();

      if (mounted) {
        if (docSnapshot.exists) {
          setState(() {
            name = docSnapshot['name'];
            domain = docSnapshot['domain'];
            batch = docSnapshot['batchNo'];
            email = docSnapshot['email'];
            phoneNo = docSnapshot['phoneNumber'];
          });
        } else {
          print('Document does not exist');
        }
      }
    } catch (e) {
      // Handle errors
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height / 2.5,
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2, right: 30),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFF3B4447),
                              radius: 70,
                              child: Center(
                                child: Text(
                                  name.isNotEmpty ? name[0] : 'A',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.inter().fontFamily),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              domain,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3.0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                height: 600,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Batch: $batch',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF585858),
                            fontFamily: GoogleFonts.inter().fontFamily),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Email: $email',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontFamily: GoogleFonts.inter().fontFamily),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Phone no: $phoneNo',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontFamily: GoogleFonts.inter().fontFamily),
                      ),
               
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}