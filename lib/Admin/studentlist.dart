import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Admin/addstudents.dart';
import 'package:themanifestapp/Admin/weekcreation.dart';
import 'package:themanifestapp/db/firebasedatabase.dart';
import 'package:themanifestapp/widgets/search.dart';
import 'package:themanifestapp/widgets/showedit.dart';

class StudentList extends StatefulWidget {
  const StudentList({
    Key? key,
    required this.batchNo,
  }) : super(key: key);

  final String batchNo;

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  String _searchTerm = '';
  late Stream<QuerySnapshot> _studentsStream;
  late String _batchNo;

  @override
  void initState() {
    super.initState();
    _batchNo = widget.batchNo;
    _studentsStream = FirebaseFirestore.instance
        .collection('students')
        .where('batchNo', isEqualTo: _batchNo)
        .snapshots();
  }

  Future<void> deleteStudent(String studentId, String batchNo) async {
    await MyFirebaseDatabase.deleteStudent(studentId, batchNo);
  }

  String get batchNo => _batchNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'Students in Batch: $_batchNo',
          style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Searchbar(
            onSearchChanged: (value) =>
                setState(() => _searchTerm = value.toLowerCase()),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _studentsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;
                  final filteredDocuments = documents
                      .where((doc) =>
                          doc['name'].toLowerCase().contains(_searchTerm))
                      .toList();
                  print("Names of students in Batch $_batchNo:");
                  for (var doc in filteredDocuments) {
                    final studentData = doc.data() as Map<String, dynamic>;
                    final name = studentData['name'] ?? '';
                    print(name);
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: filteredDocuments.length,
                      itemBuilder: (context, index) {
                        final studentData = filteredDocuments[index].data()
                            as Map<String, dynamic>;
                        final name = studentData['name'] ?? '';
                        final domain = studentData['domain'] ?? '';

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeekCreationPage(
                                  studentId: filteredDocuments[index].id,
                                  studentName: name,
                                  weekNumber: filteredDocuments[index]
                                      .id, // Pass the appropriate weekNumber
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: const Color(0xFF202628),
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xFF3B4447),
                                  radius: 28.0,
                                  child: Center(
                                    child: Text(
                                      name.substring(0, 1).toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                                subtitle: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Text(
                                      domain,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: PopupMenuButton<String>(
                                    icon: const Icon(Icons.more_vert),
                                    color: const Color(0xFF202628),
                                    itemBuilder: (context) => [
                                          PopupMenuItem<String>(
                                            value: 'edit',
                                            child: Text(
                                              'Edit',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'delete',
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                              ),
                                            ),
                                          ),
                                        ],
                                    onSelected: (value) async {
                                      if (value == 'edit') {
                                        showEditDialog(
                                          context,
                                          filteredDocuments[index].id,
                                          studentData['name'],
                                          studentData['phoneNumber'],
                                          studentData['password'],
                                        );
                                      } else if (value == 'delete') {
                                        await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Delete Student'),
                                            content: Text(
                                                'Are you sure you want to delete $name?'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await deleteStudent(
                                                      filteredDocuments[index]
                                                          .id,
                                                      batchNo);
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                ),
                                                child: const Text('Delete'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    })),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF202628),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStudent()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
