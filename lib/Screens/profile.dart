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
  Map<String, dynamic>? currentUser; // Change the type to Map<String, dynamic>?
  @override
  @override
  void initState() {
    super.initState();
    final userBox = Hive.box<Map<String, dynamic>>('userDetails');
    currentUser = userBox.get('userDetails');

    if (currentUser != null) {
      // Print individual properties for debugging
      print("Name: ${currentUser?['name']}");
      print("Domain: ${currentUser?['domain']}");
      print("BatchNo: ${currentUser?['batchNo']}");
      print("Email: ${currentUser?['email']}");
      print("PhoneNumber: ${currentUser?['phoneNumber']}");
    } else {
      print("User details not found in Hive.");
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = currentUser?['name'] ?? 'N/A';
    String domain = currentUser?['domain'] ?? 'N/A';
    String batch = currentUser?['batchNo'] ?? 'N/A';
    String email = currentUser?['email'] ?? 'N/A';
    String phoneNo = currentUser?['phoneNumber'] ?? 'N/A';
    savetoHive();
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
                    padding: const EdgeInsets.only(top: 2, right: 30),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFF3B4447),
                              radius: 70,
                              child: Center(
                                child: Text(
                                  name.isNotEmpty ? name[0] : 'A',
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
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              domain,
                              style: const TextStyle(
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
                        'Batch: "$batch"',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF585858),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Email: $email',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Phone no: $phoneNo',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
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
}

Future<void> savetoHive() async {
  final userBox = Hive.box<Map<String, dynamic>>('userDetails');
  final storedDetails = userBox.get('userDetails');
  print('User Details in Hive: $storedDetails');
}
