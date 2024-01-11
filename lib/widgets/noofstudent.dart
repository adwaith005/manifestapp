  import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> getNumberOfStudents(String batchNo) async {
    try {
      DocumentSnapshot batchSnapshot = await FirebaseFirestore.instance
          .collection('Batches')
          .doc(batchNo)
          .get();

      List<dynamic> students = batchSnapshot['students'];
      return students.length;
    } catch (error) {
      print("Error getting the number of students: $error");
      return 0;
    }
  }