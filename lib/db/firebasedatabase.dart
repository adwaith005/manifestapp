import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirebaseDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBatch(String batchNo, String batchName) async {
    try {
      await _firestore.collection("Batches").doc(batchNo).set({
        'batchName': batchName,
      });
      print("Batch added successfully!");
    } catch (error) {
      print("Error adding batch: $error");
    }
  }

  Stream<QuerySnapshot> getBatchesStream() {
    return _firestore.collection("Batches").snapshots();
  }

  Future<void> addStudent({
    required String batchNo,
    required String name,
    required String email,
    required String phoneNumber,
    required String domain,
    required String password,
  }) async {
    try {
      await _firestore
          .collection("Batches")
          .doc(batchNo)
          .collection("students")
          .doc(email)
          .set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'domain': domain,
        'password': password,
      });
      log("Student added successfully!");
    } catch (error) {
      log("Error adding student: $error");
    }
  }

  Future<void> deleteBatch(DocumentReference batchRef) async {
    await batchRef.delete();

    // Delete all student documents within the batch
    final studentsCollection = batchRef.collection('students');
    final studentSnapshots = await studentsCollection.get();
    for (var snapshot in studentSnapshots.docs) {
      await snapshot.reference.delete();
    }
  }
   Future<Map<String, dynamic>> getUserDetails(String batchNo, String email) async {
    try {
      final studentRef = _firestore
          .collection("Batches")
          .doc(batchNo)
          .collection("students")
          .doc(email);

      final studentSnapshot = await studentRef.get();
      if (studentSnapshot.exists) {
        return studentSnapshot.data() as Map<String, dynamic>;
      } else {
        log("User not found");
        return {};
      }
    } catch (error) {
      log("Error fetching user details: $error");
      return {};
    }
  }
}
