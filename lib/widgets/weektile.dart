import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Admin/manifestupload.dart';

Widget buildWeekTile(BuildContext context, String studentId, String weekNumber, QueryDocumentSnapshot<Map<String, dynamic>> weekData) {
  print("Week Number: $weekNumber");

  return Builder(
    builder: (BuildContext newContext) {
      return GestureDetector(
        onTap: () {
          Navigator.of(newContext).push(
            MaterialPageRoute(
              builder: (context) => ManifestUpload(
                studentId: studentId,
                weekNumber: weekNumber,
              ),
            ),
          );
        },
        onLongPress: () {
          showDialog(
            context: newContext,
            builder: (context) {
              return AlertDialog(
                title: const Text('Confirm Deletion'),
                content: const Text('Are you sure you want to delete this week?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Implement the logic to delete the week
                      await FirebaseFirestore.instance
                          .collection('students')
                          .doc(studentId)
                          .collection('weeks')
                          .doc(weekNumber)
                          .delete();

                      Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  ),
                ],
              );
            },
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Week',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Center(
                  child: Text(
                    weekNumber.isEmpty ? 'No Week' : weekNumber,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: GoogleFonts.poppins().fontFamily,
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
}
