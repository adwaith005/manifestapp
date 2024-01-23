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
      await _firestore.runTransaction((Transaction transaction) async {
        DocumentSnapshot batchSnapshot = await transaction
            .get(_firestore.collection("Batches").doc(batchNo));
        if (!batchSnapshot.exists) {
          transaction.set(
            _firestore.collection("Batches").doc(batchNo),
            {'students': [], 'batch': batchNo},
          );
        }
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
      DocumentSnapshot batchSnapshot =
          await _firestore.collection("Batches").doc(batchNo).get();
      List<String> students =
          List<String>.from(batchSnapshot['students'] ?? []);

      for (String studentId in students) {
        await _deleteStudent(studentId);
      }

      await _firestore.collection("Batches").doc(batchNo).delete();
      log("Batch deleted: $batchNo");
    } catch (error) {
      log("Error deleting batch: $error");
    }
  }

  Future<void> _deleteStudent(String studentId) async {
    try {
      await _firestore.collection("students").doc(studentId).delete();
      log("Student deleted: $studentId");

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        log("Firebase Authentication user deleted: ${user.uid}");
      }
    } catch (error) {
      log("Error deleting student: $error");
    }
  }

  static Future<void> deleteStudent(String studentId, String batchNo) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(studentId)
        .delete();
    await FirebaseFirestore.instance.collection('Batches').doc(batchNo).update({
      'students': FieldValue.arrayRemove([studentId]),
    });
  }
}
