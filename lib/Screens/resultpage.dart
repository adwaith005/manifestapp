import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart'; // Import the intl package

class Resultpage extends StatefulWidget {
  final String weekNumber;
  final String uid;

  const Resultpage({
    Key? key,
    required this.weekNumber,
    required this.uid,
  }) : super(key: key);

  @override
  State<Resultpage> createState() => _ResultpageState();
}

class _ResultpageState extends State<Resultpage> {
  late String weekNumber;
  String reviewDate = '';
  String reviewName = '';
  String reviewstatus = '';
  String totalMark = '';
  String advisorName = '';
  String reviewerName = '';
  String typingClub = '';
  String seminar = '';
  @override
  void initState() {
    super.initState();
    weekNumber = widget.weekNumber;
    loadExistingData();
  }

  void loadExistingData() async {
    try {
      DocumentSnapshot weekSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .doc(widget.uid)
          .collection('weeks')
          .doc(weekNumber)
          .get();

      if (weekSnapshot.exists) {
        Map<String, dynamic>? data =
            weekSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            Timestamp timestamp = data['reviewDate'] ?? Timestamp(0, 0);
            DateTime dateTime = timestamp.toDate();
            reviewDate = DateFormat('EEEE, dd MMM yyyy').format(dateTime);
            reviewName = data['reviewName'] ?? 'Not uploaded';
            reviewstatus = data['reviewstatus'] ?? 'Not Uploaded';
            totalMark = data['totalMark'] ?? '00';
            advisorName = data['advisorName'] ?? 'Notuploaded';
            reviewerName = data['reviewerName'] ?? 'Notuploaded';
            typingClub = data['typingClub'] ?? '00';
            seminar = data['seminar'] ?? 'Notupoload';
          });
        }
      }
    } catch (e) {
      print('Error loading week data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 65),
          child: Text(
            'Manifest view',
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFFCBCBCB),
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
              child: Text(
            'Week $weekNumber',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.inter().fontFamily),
          )),
          Center(
              child: Text(
            reviewDate,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.inter().fontFamily),
          )),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15),
                child: Text(
                  reviewName,
                  style: TextStyle(
                      color: const Color(0xFF575757),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.inter().fontFamily),
                ),
              )
            ],
          ),
          Row(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    height: 44,
                    width: 338,
                    child: Center(
                        child: Text(
                      reviewstatus,
                      style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.white),
                    )),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 13),
                child: Container(
                  height: 116,
                  width: 159,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(7))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Total Score',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.inter().fontFamily),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              totalMark,
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: GoogleFonts.inter().fontFamily),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              "/30",
                              style: TextStyle(
                                  color: const Color(0xFFDFDFDF),
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: GoogleFonts.inter().fontFamily),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 13),
                child: SizedBox(
                  height: 116,
                  width: 159,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Text(
                              'Advisor',
                              style: TextStyle(
                                  color: const Color(0xFFCBCBCB),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.inter().fontFamily),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              advisorName,
                              style: TextStyle(
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.inter().fontFamily),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            child: Text(
                              'Reviewer',
                              style: TextStyle(
                                  color: const Color(0xFFCBCBCB),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.inter().fontFamily),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              reviewerName,
                              style: TextStyle(
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.inter().fontFamily),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 20),
                child: Container(
                  height: 90,
                  width: 159,
                  decoration: const BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Typing club',
                          style: TextStyle(
                              color: const Color(0xFF585858),
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          typingClub,
                          style: TextStyle(
                              color: const Color(0xFF1F1F1F),
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 39),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 20),
                child: Container(
                  height: 90,
                  width: 159,
                  decoration: const BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Seminar',
                          style: TextStyle(
                              color: const Color(0xFF585858),
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          seminar,
                          style: TextStyle(
                              color: const Color(0xFF1F1F1F),
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
         
        ],
      ),
    );
  }
}
