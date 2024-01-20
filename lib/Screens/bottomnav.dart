// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Screens/home.dart';
import 'package:themanifestapp/Screens/landingpage.dart';
import 'package:themanifestapp/Screens/profile.dart';
import 'package:themanifestapp/Screens/progress.dart';

class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyBottomNavigationBar> {
  final user = FirebaseAuth.instance.currentUser!;
  String name = '';
  String email = '';
  int _currentIndex = 0;
  String _appBarTitle = 'Home';

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    if (mounted) {
      fetchStudentData(user.uid);
    }
  }

  Future<void> fetchStudentData(String uid) async {
    try {
      var studentRef = FirebaseFirestore.instance.collection('students');
      var docSnapshot = await studentRef.doc(uid).get();

      if (docSnapshot.exists) {
        setState(() {
          name = docSnapshot['name'];
          email = user.email ?? '';
        });
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // .

  @override
  Widget build(BuildContext context) {
    print('this is bottom nav bar $user.uid');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _currentIndex == 2 ? Colors.black : Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          _appBarTitle,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: _currentIndex == 2 ? Colors.white : const Color(0xFF202628),
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      endDrawer: Container(
        width: 217.0, // Set the width of the drawer
        child: MenuDrawer(name: name, email: email),
      ),
      body: _getBody(_currentIndex),
      bottomNavigationBar: ConvexAppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.show_chart, title: 'Progress'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        activeColor: Colors.black,
        color: Colors.grey,
        initialActiveIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _updateAppBarTitle();
          });
        },
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _getBody(int currentIndex) {
    // Add a check to see if the widget is still mounted
    if (!mounted) {
      return Container();
    }

    switch (currentIndex) {
      case 0:
        return HomeScreen(uid: user.uid);
      case 1:
        return ProgressScreen(uid: user.uid);
      case 2:
        return ProfileScreen(uid: user.uid);
      default:
        return Container();
    }
  }

  void _updateAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        setState(() {
          _appBarTitle = 'Home';
        });
        break;
      case 1:
        setState(() {
          _appBarTitle = 'Progress';
        });
        break;
      case 2:
        setState(() {
          _appBarTitle = 'Profile';
        });
        break;
    }
  }
}

class MenuDrawer extends StatelessWidget {
  final String name;
  final String email;

  const MenuDrawer({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF090B0B),
            ),
            accountName: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            accountEmail: Text(
              email,
              style: const TextStyle(
                color: Color(0xFF9C9C9C),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: const Color(0xFFD9D9D9),
              radius: 50,
              child: Text(
                name.isNotEmpty ? name[0] : 'A',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8A7A7A),
                ),
              ),
            ),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Landingpage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
