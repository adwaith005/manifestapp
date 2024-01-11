import 'package:flutter/material.dart';

Future<void> showWeekCreationDialog(BuildContext context) async {
  String weekInsertion = '';
  String weekName = '';

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Week Creation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Week '),
              onChanged: (value) {
                weekInsertion = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Week Name'),
              onChanged: (value) {
                weekName = value;
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Handle the logic when the user presses the "Create" button
              // You can add your Firestore logic or other actions here
              print('Week Insertion: $weekInsertion, Week Name: $weekName');
              Navigator.pop(context);
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
