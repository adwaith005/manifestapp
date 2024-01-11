
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Admin/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _batchnumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: isSmallScreen
                ? MediaQuery.of(context).size.height / 4
                : MediaQuery.of(context).size.height / 3,
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: isSmallScreen ? 110 : 110,
                      right: isSmallScreen ? 60 : 30,
                    ),
                    child: Image.asset(
                      'lib/images/manifestlogo.png',
                      height: isSmallScreen ? 50 : 80,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: isSmallScreen
                ? MediaQuery.of(context).size.height / 4.5
                : MediaQuery.of(context).size.height / 4,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: isSmallScreen ? 10 : 30,
                          top: isSmallScreen ? 80 : 60,
                        ),
                        child: Text(
                          'Hey, Welcome back to BROTOTYPE Manifest',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 31 : 31,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.inter().fontFamily,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: isSmallScreen ? 10 : 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(isSmallScreen ? 10 : 20),
                        child: TextFormField(
                          controller: _batchnumberController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Batch no:',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            enabledBorder:const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error),
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
                      Padding(
                        padding: EdgeInsets.all(isSmallScreen ? 10 : 20),
                        child: TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Enter Email :',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            enabledBorder:  const  OutlineInputBorder(
                              borderSide:  BorderSide(color: Colors.black),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email or Phonenumber';
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
                        padding: EdgeInsets.all(isSmallScreen ? 10 : 20),
                        child: TextFormField(
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Enter Password :',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            enabledBorder: const  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                      Container(
                        width: isSmallScreen ? 280 : 380,
                        height: isSmallScreen ? 50 : 60,
                        padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
                        margin: EdgeInsets.only(top: isSmallScreen ? 5 : 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF090B0B),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              // Ignore: avoid_print
                              print('object clicked');
                              // onLogin();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF090B0B),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: isSmallScreen ? 30 : 50),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Adminlogin(),
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: 'Login as ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Admin',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // Add any other styles as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: isSmallScreen ? 80 : 155,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


  // onLogin() async {
  //   try {
  //     final batchNo = _batchnumberController.text.trim();
  //     final email = emailController.text.trim();
  //     final studentRef = FirebaseFirestore.instance
  //         .collection('Batches')
  //         .doc(batchNo)
  //         .collection('students')
  //         .doc(email);
  //     final studentsnapshot = await studentRef.get();

  //     if (studentsnapshot.exists) {
  //       final studentData = studentsnapshot.data();
  //       if (studentData is Map<String, dynamic>) {
  //         if (emailController.text == studentData['email'] &&
  //             passwordController.text == studentData['password']) {
  //           log('User is logged in. User Details: $studentData');
  //           await saveUserDetails(studentData);
  //           await Hive.box<bool>('isLoggedIn').put('status', true);

  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => MyBottomNavigationBar(
  //                 batchNo: batchNo,
  //                 email: email,
  //                 userDetails: studentData,
  //               ),
  //             ),
  //           );
  //         } else {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('Invalid credentials. Please try again.'),
  //             ),
  //           );
  //         }
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Invalid data format. Please try again.'),
  //           ),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('User not found. Please check your details.'),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     log('Error during login: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('An error occurred. Please try again.'),
  //       ),
  //     );
  //   }
  // }

  // Future<void> saveUserDetails(Map<String, dynamic> userDetails) async {
  //   final userBox = Hive.box<Map<String, dynamic>>('userDetails');
  //   await userBox.put('userDetails', userDetails);
  //   print('User Details saved to Hive: $userDetails');
  // }

