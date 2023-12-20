import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Admin/addstudents.dart';
import 'package:themanifestapp/Admin/studentlist.dart';
import 'package:themanifestapp/db/firebasedatabase.dart';
import 'package:themanifestapp/widgets/search.dart';
import 'package:themanifestapp/widgets/showmodalbottamsheet.dart';

class Batches extends StatefulWidget {
  const Batches({Key? key}) : super(key: key);

  @override
  State<Batches> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Batches> {
  final MyFirebaseDatabase _firebaseDatabase = MyFirebaseDatabase();
  final _formKey = GlobalKey<FormState>();
  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Create Batch'),
              onTap: () {
                ShowModalBottomSheet.show(context, _formKey, _firebaseDatabase);
                ();
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Student'),
              onTap: () {
                // Handle the action for adding a student
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

  String _searchTerm = ''; // Store the search term here

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F6),
        body: Column(
          children: [
            // Searchbar
            Searchbar(
              onSearchChanged: (value) =>
                  setState(() => _searchTerm = value.toLowerCase()),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firebaseDatabase.getBatchesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  log('data found');
                  final documents = snapshot.data!.docs;
                  final filteredDocuments = documents
                      .where((doc) =>
                          doc['batchName'].toLowerCase().contains(_searchTerm))
                      .toList(); // Filter batch names based on search

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 0.0,
                        ),
                        itemCount: filteredDocuments.length,
                        itemBuilder: (context, index) {
                          return _buildBatchBox(filteredDocuments, index);
                        },
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF202628),
          onPressed: () {
            debugPrint('pressed');
            _showModalBottomSheet();
          },
          shape: const CircleBorder(
            side: BorderSide(color: Colors.white, width: 2.0),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildBatchBox(List<QueryDocumentSnapshot> documents, int index) {
    final batchNo = documents[index].id;
    final batchRef = documents[index].reference;

    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        top: 36,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Batch',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Center(
                child: Text(
                  batchNo,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<QuerySnapshot>(
                future: batchRef.collection('students').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final students = snapshot.data!.docs;
                    int numberOfStudents =
                        students.length > 10 ? 10 : students.length;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$numberOfStudents Students',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentList(
                  batchRef: batchRef,
                ),
              ),
            );
          },
          onLongPress: () async {
            // This will be called when the user long-presses the ListTile
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Batch'),
                content: Text(
                  'Are you sure you want to delete batch $batchNo? This action cannot be undone.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _firebaseDatabase.deleteBatch(batchRef);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      setState(() {}); // Refresh the view after deletion
                    },
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
