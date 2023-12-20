import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Admin/addstudents.dart';
import 'package:themanifestapp/widgets/long_press_detector.dart';
import 'package:themanifestapp/widgets/search.dart';
import 'package:themanifestapp/widgets/studentdelet.dart';

// Import LongPressDetectorWidget from separate file

// Implement StudentList class
class StudentList extends StatefulWidget {
  final DocumentReference batchRef;

  const StudentList({Key? key, required this.batchRef}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  String _searchTerm = '';
  late Stream<QuerySnapshot> _studentsStream;

  @override
  void initState() {
    super.initState();
    _studentsStream = widget.batchRef.collection('students').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'Students in Batch: ${widget.batchRef.id}',
          style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0), // Adjust spacing as needed
          Searchbar(
            onSearchChanged: (value) =>
                setState(() => _searchTerm = value.toLowerCase()),
          ),

          // StreamBuilder to display students with LongPressDetector
          StreamBuilder<QuerySnapshot>(
            stream: _studentsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final documents = snapshot.data!.docs;
                final filteredDocuments = documents
                    .where((doc) =>
                        doc['name'].toLowerCase().contains(_searchTerm))
                    .toList();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: filteredDocuments.length,
                    itemBuilder: (context, index) {
                      final studentData = filteredDocuments[index].data()
                          as Map<String, dynamic>;
                      final studentName = studentData['name'];

                      return Card(
                        color: const Color(0xFF202628),
                        child: LongPressDetectorWidget(
                          onLongPress: () async {
                            final documentId = filteredDocuments[index].id;
                            await showDeleteDialog(context, studentName,
                                documentId, widget.batchRef);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFF3B4447),
                              radius: 28.0,
                              child: Center(
                                child: Text(
                                  studentName.substring(0, 1).toUpperCase(),
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
                                  studentName,
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
                                  studentData['domain'],
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
                                          GoogleFonts.poppins().fontFamily,
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
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                              // Inside your _StudentListState class, update the onSelected method
                              onSelected: (value) async {
                                final documentId = filteredDocuments[index].id;
                                if (value == 'edit') {
                                  await _showEditDialog(
                                      context, studentName, documentId);
                                } else if (value == 'delete') {
                                  await showDeleteDialog(context, studentName,
                                      documentId, widget.batchRef);
                                }
                              },
                            ),
                          ),
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

  // Add this method to your _StudentListState class
  Future<void> _showEditDialog(
      BuildContext context, String studentName, String documentId) async {
    // Fetch the current student details using the documentId
    DocumentSnapshot studentSnapshot =
        await widget.batchRef.collection('students').doc(documentId).get();

    // Extract data from the snapshot with default values
    Map<String, dynamic> studentData =
        studentSnapshot.data() as Map<String, dynamic>;
    String name = studentData['name'] ?? '';
    String email = studentData['email'] ?? '';
    String phoneNumber = studentData['phoneNumber'] ?? '';
    String domain = studentData['domain'] ?? '';
    String password = studentData['password'] ?? '';

    // Create controllers and set initial values
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController phoneNumberController =
        TextEditingController(text: phoneNumber);
    TextEditingController domainController =
        TextEditingController(text: domain);
    TextEditingController passwordController =
        TextEditingController(text: password);

    // Show the dialog with the form for editing details
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Edit Student Details'),
        content: SingleChildScrollView(
          child: Form(
            // Use the same form key if needed
            child: Column(
              children: [
                // Add TextFormField widgets for other fields as needed
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
                TextFormField(
                  controller: domainController,
                  decoration: const InputDecoration(labelText: 'Domain'),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              // Perform the update operation
              await widget.batchRef
                  .collection('students')
                  .doc(documentId)
                  .update({
                'name': nameController.text,
                'email': emailController.text,
                'phoneNumber': phoneNumberController.text,
                'domain': domainController.text,
                'password': passwordController.text,
              });

              // Close the dialog
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
