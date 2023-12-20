// Inside delete_dialog.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteDialog extends StatelessWidget {
  final String studentName;
  final String documentId;
  final VoidCallback onDelete;

  const DeleteDialog({
    required this.studentName,
    required this.documentId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const  Color(0xFF090B0B),
      title: Text("Delete Student?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          )),
      content: Text("Are you sure you want to delete $studentName?",  style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          )),
      actions: [
        TextButton(
          child:  Text("Cancel",  style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          )),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child:  Text("Delete",  style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          )),
          onPressed: () {
            // Call the onDelete callback
            onDelete();
            // Close the dialog
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
   
}
