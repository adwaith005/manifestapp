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
        title: Center(
          child: Text(
            'Manifest view',
            style: TextStyle(
              fontSize: isSmallScreen ? 13 : 23,
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
                    fontSize: isSmallScreen ? 20 : 30,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              ),
              Center(
                child: Text(
                  reviewDate,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 26,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              ),
              Row(
                
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: isSmallScreen ? 20 : 25,
                        left: isSmallScreen ? 20 : 15),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: isSmallScreen ? 0 : 10,
                          top: isSmallScreen ? 5 : 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: getReviewStatusColor(totalMark, theoryMark,
                              practicalMark, reviewstatus),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                        ),
                        width: isSmallScreen ? 360 : 1900,
                        height: isSmallScreen ? 44 : 88,
                        child: Center(
                          child: Text(
                            reviewstatus,
                            style: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: isSmallScreen ? 20 : 30,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 0 : 250,
                        top: isSmallScreen ? 30 : 10),
                    child: Container(
                      height: isSmallScreen ? 116 : 200,
                      width: isSmallScreen ? 159 : 500,
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
                                fontSize: isSmallScreen ? 14 : 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: isSmallScreen ? 30 : 180),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Center(
                                    child: Text(
                                      totalMark,
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 35 : 60,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Center(
                                  child: Text(
                                    "/30",
                                    style: TextStyle(
                                      color: const Color(0xFFDFDFDF),
                                      fontSize: isSmallScreen ? 35 : 60,
                                      fontWeight: FontWeight.w700,
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: isSmallScreen ? 25 : 10,
                      left: isSmallScreen ? 0 : 450,
                    ),
                    child: SizedBox(
                      height: isSmallScreen ? 116 : 200,
                      width: isSmallScreen ? 159 : 500,
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
                                    fontSize: isSmallScreen ? 15 : 30,
                                    fontFamily: GoogleFonts.inter().fontFamily,
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
                                    fontSize: isSmallScreen ? 16 : 30 ,
                                    fontFamily: GoogleFonts.inter().fontFamily,
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
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 0 : 250,
                        top: isSmallScreen ? 25 : 30),
                    child: Container(
                      height: isSmallScreen ? 116 : 200,
                      width: isSmallScreen ? 159 : 500,
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
                                fontSize: isSmallScreen ? 16 : 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: isSmallScreen ? 5 : 30),
                            child: Text(
                              typingClub,
                              style: TextStyle(
                                color: const Color(0xFF1F1F1F),
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: isSmallScreen ? 35 : 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 0 : 450,
                        top: isSmallScreen ? 25 : 10),
                    child: Container(
                height: isSmallScreen ? 116 : 200,
                      width: isSmallScreen ? 159 : 500,
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
                                  fontSize: isSmallScreen ? 16 : 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: isSmallScreen ? 5 : 30,
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
                                    fontSize: isSmallScreen ? 20 : 50,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 0 : 250,
                        top: isSmallScreen ? 10 : 10),
                    child: Container(
                      height: isSmallScreen ? 90 : 200,
                      width: isSmallScreen ? 159 : 500,
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
                                EdgeInsets.only(top: isSmallScreen ? 20 : 60),
                            child: Text(
                              theoryMark,
                              style: TextStyle(
                                color: const Color(0xFF1F1F1F),
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: isSmallScreen ? 39 : 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: isSmallScreen ? 0 : 450,
                        top: isSmallScreen ? 10 : 10),
                    child: Container(
                      height: isSmallScreen ? 90 : 200,
                      width: isSmallScreen ? 150 : 500,
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
                                EdgeInsets.only(top: isSmallScreen ? 20 : 60),
                            child: Text(
                              practicalMark,
                              style: TextStyle(
                                color: const Color(0xFF1F1F1F),
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: isSmallScreen ? 39 : 40,
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
                padding: EdgeInsets.only(top: isSmallScreen ? 20 : 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: isSmallScreen ? 260 : 300,
                          width: isSmallScreen ? 365 : 1450,
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

    if (totalMarkValue == null ||
        theoryMarkValue == null ||
        practicalMarkValue == null) {
      return Colors.grey;
    }
    print(reviewstatus);
    if (theoryMarkValue < 5 ||
        practicalMarkValue < 5 ||
        reviewstatus == 'Week Repeat') {
      return const Color(0xFF00ffff);
    } else if (reviewstatus == 'Task Incomplete') {
      return const Color(0xFFff0000);
    } else if (totalMarkValue >= 5 && totalMarkValue <= 10) {
      return const Color(0xFFff9900);
    } else if (totalMarkValue > 10 && totalMarkValue <= 13) {
      return const Color(0xFFffff00);
    } else {
      return const Color(0xFF00ff00);
    }
  }
}
