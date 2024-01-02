import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/db/firebasedatabase.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _batchnumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> studentData = {};
  String imageUrl = '';
  List<String> domainOptions = [
    'Mern',
    'Mean',
    'Python (Django)',
    'Flutter',
    'Golang',
    'Kotin ',
    'Game Development',
    'Data Science',
    'Cyber Security'
  ];
  String? selectedDomain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Add Students',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: _nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'Enter Name (As per ID card) :',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (!isFirstLetterCaps(value)) {
                          return 'Name should start with a capital letter';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'Enter email :',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@gmail.com')) {
                          return 'Please enter a valid Gmail address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: _phonenumberController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Enter Phone number:',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length != 10 ||
                            !RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _batchnumberController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Batch no:',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a batch no';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<String>(
                            value: selectedDomain,
                            onChanged: (value) {
                              setState(() {
                                selectedDomain = value;
                              });
                            },
                            items: domainOptions.map((domain) {
                              return DropdownMenuItem(
                                value: domain,
                                child: Text(
                                  domain,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Domain:',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            dropdownColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a domain';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Enter password :',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: _confirmpasswordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm password :',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String phoneNumber = _phonenumberController.text;
                        String batchNo = _batchnumberController.text;
                        String domain = selectedDomain ?? '';
                        String password = _passwordController.text;

                        // Check if the user already exists with the provided phone number or email
                        bool userExists = await checkIfUserExists(
                            batchNo, phoneNumber, email);

                        if (userExists) {
                          // Show an error message or handle the case where the user already exists
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'User with the provided phone number or email already exists.',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                          _nameController.clear();
                          _emailController.clear();
                          _phonenumberController.clear();
                          _batchnumberController.clear();
                          _passwordController.clear();
                          _confirmpasswordController.clear();
                          // Reset the selected domain
                          setState(() {
                            selectedDomain = null;
                          });
                        } else {
                          // Instantiate your Firebase class
                          MyFirebaseDatabase firebaseDatabase =
                              MyFirebaseDatabase();

                          // Add the batch if it doesn't exist
                          await firebaseDatabase.addBatch(
                              batchNo, "Batch $batchNo");

                          // Add the student to the batch
                          await firebaseDatabase.addStudent(
                            batchNo: batchNo,
                            name: name,
                            email: email,
                            phoneNumber: phoneNumber,
                            domain: domain,
                            password: password,
                            // Add the download URL here
                          );

                          // After saving, you may want to navigate back to the StudentList
                          Navigator.pop(context);
                        }
                      }
                    }, // <-- Add a comma here
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF202628),
                      ),
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(270, 57)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(width: 2.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isFirstLetterCaps(String value) {
    // Check if the first letter is in uppercase
    return value.isNotEmpty && value[0] == value[0].toUpperCase();
  }

  Future<bool> checkIfUserExists(
      String batchNo, String phoneNumber, String email) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Batches') // Replace 'Batches' with your collection name
        .doc(batchNo)
        .collection('students')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    // Check if there is any document with the provided phone number
    if (querySnapshot.docs.isNotEmpty) {
      return true;
    }

    // If no user found with the phone number, check with the email
    querySnapshot = await FirebaseFirestore.instance
        .collection('Batches') // Replace 'Batches' with your collection name
        .doc(batchNo)
        .collection('students')
        .where('email', isEqualTo: email)
        .get();

    // Check if there is any document with the provided email
    return querySnapshot.docs.isNotEmpty;
  }
}
