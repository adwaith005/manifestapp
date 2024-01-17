import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/widgets/dialog_helpers.dart' as dialogHelpers;
import 'package:themanifestapp/widgets/showedit.dart';
import 'package:themanifestapp/widgets/weektile.dart';

class WeekCreationPage extends StatelessWidget {
  final String studentId;
  final String studentName;
  final String weekNumber;

  const WeekCreationPage({
    Key? key,
    required this.studentId,
    required this.studentName,
    required this.weekNumber,
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
            var studentData = (snapshot.data)?.docs;
            if (studentData != null && studentData.isNotEmpty) {
              var studentDomain = (studentData[0].data())['domain'];
              String studentId = studentData[0].id;
              String currentName = (studentData[0].data())['name'];
              String currentPhoneNumber =
                  (studentData[0].data())['phoneNumber'];
              String currentPassword = (studentData[0].data())['password'];
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
                                      // ignore: avoid_print
                                      print('Edit pressed for $studentName');
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("students")
                                    .doc(studentId)
                                    .collection('weeks')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var weekData = (snapshot.data)?.docs;
                                    if (weekData != null &&
                                        weekData.isNotEmpty) {
                                      return GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20.0,
                                                mainAxisSpacing: 20.0,
                                                childAspectRatio: 3 / 2.4),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: weekData.length,
                                        itemBuilder: (context, index) {
                                          var weekDocument = weekData[index];
                                          var weekNumber = weekDocument.id;
                                          return buildWeekTile(
                                              context,
                                              studentId,
                                              weekNumber,
                                              weekDocument);
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
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: SpeedDial(
                      backgroundColor: const Color(0xFF202628),
                      animatedIcon: AnimatedIcons.menu_close,
                      animatedIconTheme:
                          const IconThemeData(size: 22.0, color: Colors.white),
                      visible: true,
                      curve: Curves.bounceIn,
                      children: [
                        SpeedDialChild(
                          child: const Icon(Icons.add, color: Colors.white),
                          backgroundColor: const Color(0xFF202628),
                          onTap: () {
                            dialogHelpers.showWeekCreationDialog(
                              context,
                              studentId: studentId,
                              studentName: studentName,
                            );
                          },
                          label: 'Create Week',
                          labelStyle: const TextStyle(
                              fontSize: 16.0, color: Colors.white),
                          labelBackgroundColor: Colors.black,
                        ),
                      ],
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
}
