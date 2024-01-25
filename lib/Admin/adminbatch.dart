import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Admin/addstudents.dart';
import 'package:themanifestapp/Admin/studentlist.dart';
import 'package:themanifestapp/db/firebasedatabase.dart';
import 'package:themanifestapp/widgets/noofstudent.dart';
import 'package:themanifestapp/widgets/search.dart';
import 'package:themanifestapp/widgets/showmodalbottamsheet.dart';

class Batches extends StatefulWidget {
  const Batches({
    Key? key,
  }) : super(key: key);

  @override
  State<Batches> createState() => _BatchesState();
}

class _BatchesState extends State<Batches> {
  final MyFirebaseDatabase _firebaseDatabase = MyFirebaseDatabase();
  final _formKey = GlobalKey<FormState>();
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F6),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Searchbar(
                onSearchChanged: (value) =>
                    setState(() => searchTerm = value.toLowerCase()),
              ),
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Batches').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );
                }

                List<Widget> batchWidgets = [];

                for (var document in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  if (searchTerm.isEmpty ||
                      data['batch'].toLowerCase().contains(searchTerm)) {
                    batchWidgets.add(
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentList(
                                  batchNo: data['batch'] ?? 'Default Batch'),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onLongPress: () => _showDeleteDialog(data['batch']),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 2),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFEFEF),
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Batch',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Center(
                                          child: Text(
                                            data['batch'] ?? 'Default Batch',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FutureBuilder<int>(
                                              future: getNumberOfStudents(
                                                  data['batch']),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Text(
                                                    'Loading...',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return const Text(
                                                    'Error',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  );
                                                } else {
                                                  return Container(
                                                    width: 166,
                                                    height: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xFF090B0B),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(4),
                                                        bottomRight:
                                                            Radius.circular(4),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${snapshot.data} Students',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ])),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 3 / 2),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return batchWidgets[index];
                    },
                    childCount: batchWidgets.length,
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.black,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme:
              const IconThemeData(size: 22.0, color: Colors.white),
          visible: true,
          curve: Curves.decelerate,
          spaceBetweenChildren: 12,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFF202628),
              label: 'Create Batch',
              labelStyle: const TextStyle(fontSize: 16.0),
              labelBackgroundColor: Colors.white,
              onTap: () {
                ShowModalBottomSheet.show(context, _formKey, _firebaseDatabase);
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFF202628),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddStudent()),
                );
              },
              label: 'Add Student',
              labelStyle: const  TextStyle(fontSize: 16.0),
              labelBackgroundColor: Colors.white,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }


  void _showDeleteDialog(String batchNo) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text('Do you want to delete the batch $batchNo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _firebaseDatabase.deleteBatch(batchNo);
                Navigator.pop(ctx);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
