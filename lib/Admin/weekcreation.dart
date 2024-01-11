import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/widgets/showedit.dart';
import 'package:themanifestapp/widgets/weekcreation.dart';

class WeekCreationPage extends StatelessWidget {
  final String studentName;

  const WeekCreationPage({
    Key? key,
    required this.studentName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('students')
            .where('name', isEqualTo: studentName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var studentData = (snapshot.data as QuerySnapshot?)?.docs;
            if (studentData != null && studentData.isNotEmpty) {
              var studentDomain =
                  (studentData[0].data() as Map<String, dynamic>?)?['domain'];

              // Extracting student information
              String studentId = studentData[0].id;
              String currentName =
                  (studentData[0].data() as Map<String, dynamic>)['name'];
              String currentPhoneNumber = (studentData[0].data()
                  as Map<String, dynamic>)['phoneNumber'];
              String currentPassword =
                  (studentData[0].data() as Map<String, dynamic>)['password'];

              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: isSmallScreen
                        ? MediaQuery.of(context).size.height / 1.45
                        : MediaQuery.of(context).size.height / 3,
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 16.0,
                              top: 16.0,
                              left: 16.0,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const Spacer(),
                                PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      print('Edit pressed for $studentName');
                                      // Passing student information to the edit dialog
                                      showEditDialog(
                                        context,
                                        studentId,
                                        currentName,
                                        currentPhoneNumber,
                                        currentPassword,
                                      );
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: const Color(0xFF3B4447),
                            radius: 50,
                            child: Center(
                              child: Text(
                                studentName.isNotEmpty
                                    ? studentName[0].toUpperCase()
                                    : 'A',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            studentName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            studentDomain ?? 'No Domain',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: isSmallScreen
                        ? MediaQuery.of(context).size.height / 3
                        : MediaQuery.of(context).size.height / 4,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: FloatingActionButton(
                      backgroundColor: const Color(0xFF202628),

                      onPressed: () {
                        showWeekCreationDialog(context);
                      }, // Add your onPressed function here
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> showDeleteDialog(
      BuildContext context, String studentId, String studentName) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: Text('Are you sure you want to delete $studentName?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
