import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Admin/login.dart';
import 'package:themanifestapp/Screens/bottomnav.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0, // Adjust the top position based on the image height
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height / 4, // Adjust height
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 120, right: 30),
                    child: Image.asset(
                      'lib/images/manifestlogo.png',
                      height: 80,
                    ),
                  )
                ],
              ),
            ),
          ),

          // White background with rounded corners
          Positioned(
            top: MediaQuery.of(context).size.height / 4, // Adjust position
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 60),
                        child: Text(
                          'Hey, Welcome back to BROTOTYPE Manifest',
                          style: TextStyle(
                            fontSize: 31,
                            fontWeight: FontWeight.w700,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: _batchnumberController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Batch no:',
                            labelStyle: TextStyle(
                              color:
                                  Colors.black, // Change to black for contrast
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black), // Change to black
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black), // Change to black
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black, // Change to black for contrast
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
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Enter Email or phone no:',
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
                        padding: const EdgeInsets.all(20.0),
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
                            enabledBorder: const OutlineInputBorder(
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
                        width: 380,
                        height: 60,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF090B0B),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              print('object clicked');
                              onLogin();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF090B0B),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to another page when "Admin" is tapped
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
                                // Add any styles for the non-bold part
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

  onLogin() async {
    final batchNo = _batchnumberController.text.toString();
    final email = emailController.text.toString();

    final studentRef = FirebaseFirestore.instance
        .collection('Batches')
        .doc(batchNo)
        .collection('students')
        .doc(email);
    final studentsnapshot = await studentRef.get();

    if (studentsnapshot.exists) {
      // Check if the document exists before accessing its data
      final studentData = studentsnapshot.data() as Map<String, dynamic>;

      if (emailController.text == studentData['email'] &&
          passwordController.text == studentData['password']) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const bottomNavigationBar(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid credentials. Please try again.'),
          ),
        );
      }
    } else {
      // Show snackbar for user not found
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not found. Please check your details.'),
        ),
      );
    }
  }
}
