import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyFirebaseDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStudent({
    required String batchNo,
    required String name,
    required String email,
    required String phoneNumber,
    required String domain,
    required String password,
    required String currentUserId,
  }) async {
    try {
      // Use a transaction for atomic batch creation
      await _firestore.runTransaction((Transaction transaction) async {
        // Check if the batch exists, and create it if not
        DocumentSnapshot batchSnapshot = await transaction
            .get(_firestore.collection("Batches").doc(batchNo));
        if (!batchSnapshot.exists) {
          transaction.set(
            _firestore.collection("Batches").doc(batchNo),
            {'students': [], 'batch': batchNo},
          );
        }

        // Add the student to the batch
        transaction.set(
          _firestore.collection("students").doc(currentUserId),
          {
            'id': currentUserId,
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'domain': domain,
            'password': password,
            'batchNo': batchNo,
          },
        );

        // Update the batch with the new student
        transaction.update(
          _firestore.collection("Batches").doc(batchNo),
          {
            'students': FieldValue.arrayUnion([currentUserId]),
          },
        );
      });

      log("Student added successfully!");
    } catch (error) {
      log("Error adding student: $error");
    }
  }

  Future<bool> checkIfBatchExists(String batchNo) async {
    try {
      DocumentSnapshot batchSnapshot =
          await _firestore.collection("Batches").doc(batchNo).get();

      return batchSnapshot.exists;
    } catch (error) {
      print("Error checking if batch exists: $error");
      return false;
    }
  }

  Future<void> addBatch(String batchNo, [String? currentUserId]) async {
    try {
      if (currentUserId != null) {
        await _firestore.collection("Batches").doc(batchNo).update({
          'students': FieldValue.arrayUnion([currentUserId]),
        });
      } else {
        await _firestore
            .collection("Batches")
            .doc(batchNo)
            .set({'students': [], 'batch': batchNo});
      }
      print("Batch added $batchNo!");
    } catch (error) {
      print("Error adding batch: $error");
    }
  }

  Future<void> deleteBatch(String batchNo) async {
    try {
      // Fetch the list of students in the batch
      DocumentSnapshot batchSnapshot =
          await _firestore.collection("Batches").doc(batchNo).get();
      List<String> students =
          List<String>.from(batchSnapshot['students'] ?? []);

      // Delete each student and associated Firebase Authentication user
      for (String studentId in students) {
        await _deleteStudent(studentId);
      }

      // Delete the batch
      await _firestore.collection("Batches").doc(batchNo).delete();
      log("Batch deleted: $batchNo");
    } catch (error) {
      log("Error deleting batch: $error");
    }
  }

  Future<void> _deleteStudent(String studentId) async {
    try {
      // Delete student from the "students" collection
      await _firestore.collection("students").doc(studentId).delete();
      log("Student deleted: $studentId");

      // Delete Firebase Authentication user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        log("Firebase Authentication user deleted: ${user.uid}");
      }
    } catch (error) {
      log("Error deleting student: $error");
    }
  }
}
