import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
  String theoryMark = '';
  String practicalMark = '';
  String pendingTopics = '';
  @override
  void initState() {
    super.initState();
    weekNumber = widget.weekNumber;
    loadExistingData();
  }

  Future<void> _refreshData() async {
    await loadExistingData();
  }

  Future<void> loadExistingData() async {
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
            theoryMark = data['theoryMark'] ?? '00';
            practicalMark = data['practicalMark'] ?? '00';
            pendingTopics = data['pendingTopics'] ?? 'Notuploaded';
          });
        }
      }
    } catch (e) {
      print('Error loading week data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: isSmallScreen ? 80 : 65),
          child: Text(
            'Manifest view',
            style: TextStyle(
              fontSize: isSmallScreen ? 13 : 13,
              color: const Color(0xFFCBCBCB),
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Week $weekNumber',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              ),
              Center(
                child: Text(
                  reviewDate,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: isSmallScreen ? 20 : 20,
                        left: isSmallScreen ? 15 : 15),
                    child: Text(
                      reviewName,
                      style: TextStyle(
                        color: const Color(0xFF575757),
                        fontSize: isSmallScreen ? 20 : 25,
                        fontWeight: FontWeight.w700,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: isSmallScreen ? 15 : 10,
                          top: isSmallScreen ? 5 : 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: getReviewStatusColor(totalMark, theoryMark,
                              practicalMark, reviewstatus),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                        ),
                        height: isSmallScreen ? 44 : 28,
                        width: isSmallScreen ? 330 : 380,
                        child: Center(
                          child: Text(
                            reviewstatus,
                            style: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: isSmallScreen ? 20 : 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: isSmallScreen ? 15 : 10,
                          top: isSmallScreen ? 30 : 10),
                      child: Container(
                        height: isSmallScreen ? 116 : 80,
                        width: isSmallScreen ? 140 : 100,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: isSmallScreen ? 10 : 5),
                              child: Text(
                                'Total Score',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 10,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: isSmallScreen ? 20 : 10),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      totalMark,
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 35 : 24,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Text(
                                    "/30",
                                    style: TextStyle(
                                      color: const Color(0xFFDFDFDF),
                                      fontSize: isSmallScreen ? 35 : 24,
                                      fontWeight: FontWeight.w700,
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: isSmallScreen ? 25 : 10,
                        left: isSmallScreen ? 15 : 10,
                      ),
                      child: SizedBox(
                        height: isSmallScreen ? 116 : 80,
                        width: isSmallScreen ? 159 : 100,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: isSmallScreen ? 10 : 5,
                                      left: isSmallScreen ? 10 : 5),
                                  child: Text(
                                    'Advisor',
                                    style: TextStyle(
                                      color: const Color(0xFFCBCBCB),
                                      fontWeight: FontWeight.w500,
                                      fontSize: isSmallScreen ? 15 : 10,
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      advisorName,
                                      style: TextStyle(
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.bold,
                                        fontSize: isSmallScreen ? 20 : 15,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0, left: isSmallScreen ? 10 : 5),
                                  child: Text(
                                    'Reviewer',
                                    style: TextStyle(
                                      color: const Color(0xFFCBCBCB),
                                      fontWeight: FontWeight.w500,
                                      fontSize: isSmallScreen ? 16 : 10,
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      reviewerName,
                                      style: TextStyle(
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.bold,
                                        fontSize: isSmallScreen ? 22 : 16,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 15 : 10,
                        top: isSmallScreen ? 25 : 5),
                    child: Container(
                      height: isSmallScreen ? 100 : 60,
                      width: isSmallScreen ? 159 : 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: isSmallScreen ? 10 : 5),
                            child: Text(
                              'Typing club',
                              style: TextStyle(
                                color: const Color(0xFF585858),
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: isSmallScreen ? 16 : 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: isSmallScreen ? 5 : 0),
                            child: Text(
                              typingClub,
                              style: TextStyle(
                                color: const Color(0xFF1F1F1F),
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: isSmallScreen ? 35 : 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 25 : 10,
                        top: isSmallScreen ? 25 : 5),
                    child: Container(
                      height: isSmallScreen ? 100 : 60,
                      width: isSmallScreen ? 150 : 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: isSmallScreen ? 10 : 5),
                            child: Center(
                              child: Text(
                                'Seminar',
                                style: TextStyle(
                                  color: const Color(0xFF1F1F1F),
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w600,
                                  fontSize: isSmallScreen ? 16 : 12,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: isSmallScreen ? 5 : 0,
                              left: isSmallScreen ? 5 : 10,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Center(
                                child: Text(
                                  seminar,
                                  style: TextStyle(
                                    color: const Color(0xFF1F1F1F),
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isSmallScreen ? 20 : 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: isSmallScreen ? 10 : 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Theory',
                      style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'Practical',
                      style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 15 : 10,
                        top: isSmallScreen ? 10 : 5),
                    child: Container(
                      height: isSmallScreen ? 90 : 60,
                      width: isSmallScreen ? 159 : 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F1),
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(1)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: isSmallScreen ? 20 : 0),
                            child: Text(
                              theoryMark,
                              style: TextStyle(
                                color: const Color(0xFF1F1F1F),
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: isSmallScreen ? 39 : 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 25 : 10,
                        top: isSmallScreen ? 10 : 5),
                    child: Container(
                      height: isSmallScreen ? 90 : 60,
                      width: isSmallScreen ? 150 : 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F1),
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(1)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: isSmallScreen ? 20 : 0),
                            child: Text(
                              practicalMark,
                              style: TextStyle(
                                color: const Color(0xFF1F1F1F),
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: isSmallScreen ? 39 : 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: isSmallScreen ? 20 : 0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 260,
                          width: 365,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                            color: const Color(0xFFEEEEEE),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: isSmallScreen ? 10 : 10,
                                  top: isSmallScreen ? 10 : 5,
                                ),
                                child: Text(
                                  'Pending Topics',
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Flexible(
                                // or Expanded
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: isSmallScreen ? 10 : 10,
                                    top: isSmallScreen ? 10 : 5,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      pendingTopics,
                                      style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getReviewStatusColor(String totalMark, String theoryMark,
      String practicalMark, String reviewstatus) {
    double? totalMarkValue = double.tryParse(totalMark);
    double? theoryMarkValue = double.tryParse(theoryMark);
    double? practicalMarkValue = double.tryParse(practicalMark);

    if (totalMarkValue == null) {
      print('Error parsing totalMark: $totalMark');
    }
    if (theoryMarkValue == null) {
      print('Error parsing theoryMark: $theoryMark');
    }
    if (practicalMarkValue == null) {
      print('Error parsing practicalMark: $practicalMark');
    }

    if (totalMarkValue == null ||
        theoryMarkValue == null ||
        practicalMarkValue == null) {
      // Handle the case where parsing fails (one or more values are not valid numbers)
      return Colors
          .grey; // or any other color you want to use for this scenario
    }

    if (theoryMarkValue < 5 ||
        practicalMarkValue < 5 ||
        reviewstatus == 'Week Repeat') {
      return Color(0xFF00ffff);
    } else if (reviewstatus == 'Task Not Completed') {
      return Color(0xFFff0000);
    } else if (totalMarkValue >= 5 && totalMarkValue <= 10) {
      return Color(0xFFff9900);
    } else if (totalMarkValue > 10 && totalMarkValue <= 13) {
      return Color(0xFFffff00);
    } else {
      return Color(0xFF00ff00);
    }
  }
}
