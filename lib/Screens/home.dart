import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Screens/resultpage.dart';
import 'package:themanifestapp/widgets/search.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  const HomeScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String _searchTerm = '';

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    fetchStudentData(widget.uid);
  }

  Future<void> fetchStudentData(String uid) async {
    try {
      var studentRef = FirebaseFirestore.instance.collection('students');
      var docSnapshot = await studentRef.doc(uid).get();

      if (docSnapshot.exists) {
        setState(() {
          name = docSnapshot['name'];
        });
      } else {
        log('Document does not exist');
      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  Future<void> _refresh() async {
    await fetchStudentData(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 25),
                    child: Text(
                      "Hello $name",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 24,
                        color: const Color(0xFF414141),
                        fontWeight: FontWeight.w900,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 10 : 25, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      "Your Reviews",
                      style: TextStyle(
                        color: const Color(0xFF414141),
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                    )
                  ],
                ),
              ),
              Searchbar(
                onSearchChanged: (value) =>
                    setState(() => _searchTerm = value.toLowerCase()),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("students")
                          .doc(widget.uid)
                          .collection('weeks')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var weekData = (snapshot.data)?.docs;
                          if (weekData != null && weekData.isNotEmpty) {
                            var filteredWeeks = weekData
                                .where((week) =>
                                    week.id.toLowerCase().contains(_searchTerm))
                                .toList();
                
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isSmallScreen ? 2 : 2,
                                crossAxisSpacing: isSmallScreen ? 13.0 : 20.0,
                                mainAxisSpacing: isSmallScreen ? 20.0 : 20.0,
                                childAspectRatio: isSmallScreen ? 1.7 : 3 / 2,
                              ),
                              shrinkWrap: true,
                              itemCount: filteredWeeks.length,
                              itemBuilder: (context, index) {
                                var weekDocument = filteredWeeks[index];
                                var weekNumber = weekDocument.id;
                            
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Resultpage(
                                          uid: widget.uid,
                                          weekNumber: weekNumber,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFEFEF),
                                      borderRadius: BorderRadius.circular(9.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          Center(
                                            child: Text(
                                              'Week',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Center(
                                            child: Text(
                                              weekNumber.isEmpty
                                                  ? 'No Week'
                                                  : weekNumber,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No weeks available'),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
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
}
