import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  final String? batchNo;
  final String? email;

  const ProfileScreen({
    Key? key,
    required this.batchNo,
    required this.email,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<dynamic,dynamic>? thisUser ;


  @override
  void initState() {
    super.initState();
    var userbox = Hive.box<Map<dynamic, dynamic>>("userDetails");
    var user = userbox.values.first;
    thisUser = user;
    print(user['password']);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height / 2,
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, right: 30),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFF3B4447),
                              radius: 80,
                              child: Center(
                                child: Text(
                                  thisUser?['name'],
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:  EdgeInsets.only(left: 30),
                            child: Text(
                              thisUser?['name'],
                              style:  TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        const  Padding(
                            padding:  EdgeInsets.only(left: 30),
                            child: Text(
                              "domain",
                              style:  TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                height: 600,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                         thisUser?['name'],
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF585858),
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Text(
                      //   'Email: $email',
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      // const SizedBox(height: 5),
                      // Text(
                      //   'Phone no: $phoneNo',
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //    Future<void> loadUserDetails() async {
  //   try {
  //     final userBox = await Hive.openBox<Map<String, dynamic>>('userDetails');
  //     final userDetails = userBox.get('userDetails');

  //     if (userDetails != null) {
  //       setState(() {
  //         name = userDetails['name'] ?? '';
  //         domain = userDetails['domain'] ?? '';
  //         email = userDetails['email'] ?? '';
  //         batchNo = userDetails['batchNo'] ?? '';
  //         phoneNo = userDetails['phoneNo'] ?? '';
  //       });
  //     }
  //   } catch (e) {
  //     print('Error loading user details: $e');
  //   }
  // }
}
