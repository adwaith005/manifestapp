import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> showEditDialog(
  BuildContext context,
  String studentId,
  String currentName,
  String currentPhoneNumber,
  String currentPassword,
) async {
  TextEditingController nameController =
      TextEditingController(text: currentName);
  TextEditingController phoneNumberController =
      TextEditingController(text: currentPhoneNumber);
  TextEditingController passwordController =
      TextEditingController(text: currentPassword);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Student'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty &&
                  phoneNumberController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                await _updateStudent(studentId, nameController.text,
                    phoneNumberController.text, passwordController.text);
                Navigator.pop(context); // Close the dialog
              } else {}
            },
            child: const Text('Update'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}



Future<void> _updateStudent(
  String studentId,
  String newName,
  String newPhoneNumber,
  String newPassword,
) async {
  try {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(studentId)
        .update({
      'name': newName,
      'phoneNumber': newPhoneNumber,
      'password': newPassword,
    });

    print('Student updated successfully!');
  } catch (error) {
    print('Error updating student: $error');
    // Handle the error (optional)
  }
}
