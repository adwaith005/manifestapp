// dialog_helpers.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showWeekCreationDialog(
  BuildContext context, {
  required String studentId,
  required String studentName,
}) async {
  String weekNumber = '';
  String weekName = '';
  final _formKey = GlobalKey<FormState>();
  final _weekNumberController = TextEditingController();
  final _weekNameController = TextEditingController();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFD9D9D9),
        title: const Text('Week Creation'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _weekNumberController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Enter week number:',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a week number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _weekNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Enter week name:',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a week name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              try {
                if (_formKey.currentState!.validate()) {
                  // Retrieve the entered values
                  weekNumber = _weekNumberController.text;
                  weekName = _weekNameController.text;

                  await FirebaseFirestore.instance
                      .collection('students')
                      .doc(studentId)
                      .collection('weeks')
                      .doc(weekNumber) // Use weekNumber as the document ID
                      .set({
                        'WeekName':weekName
                      });

                  // Close the dialog
                  Navigator.pop(context);
                }
              } catch (error) {
                print("Error creating week: $error");
              }
            },
            child: Text('Create'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle the logic when the user presses the "Cancel" button
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
