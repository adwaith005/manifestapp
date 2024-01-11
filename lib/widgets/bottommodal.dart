import 'package:flutter/material.dart';
import 'package:themanifestapp/Admin/addstudents.dart';

class ModalBottomSheet {
  static void show(BuildContext context, {
    required VoidCallback onCreateBatch,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Create Batch'),
              onTap: onCreateBatch, // Call the provided callback
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Student'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddStudent()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
