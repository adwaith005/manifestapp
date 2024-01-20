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
  final formKey = GlobalKey<FormState>();
  final weekNumberController = TextEditingController();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFD9D9D9),
        title: const Text('Week Creation'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: weekNumberController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
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
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              try {
                if (formKey.currentState!.validate()) {
                  weekNumber = weekNumberController.text;
                  await FirebaseFirestore.instance
                      .collection('students')
                      .doc(studentId)
                      .collection('weeks')
                      .doc(weekNumber) 
                      .set({
                      
                      });
                  Navigator.pop(context);
                }
              } catch (error) {
                print("Error creating week: $error");
              }
            },
            child: const  Text('Create'),
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
