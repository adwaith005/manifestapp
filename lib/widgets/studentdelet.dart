import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:themanifestapp/widgets/deleteshowdilog.dart';

Future<void> showDeleteDialog(
  BuildContext context,
  String studentName,
  String documentId,
  DocumentReference batchRef,
) async {
  return showDialog(
    context: context,
    builder: (context) => DeleteDialog(
      studentName: studentName,
      documentId: documentId,
      onDelete: () async => await batchRef
          .collection('students')
          .doc(documentId)
          .delete(),
    ),
  );
}
