// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:themanifestapp/Screens/home.dart';
import 'package:themanifestapp/Screens/profile.dart';
import 'package:themanifestapp/Screens/progress.dart';
import 'package:themanifestapp/db/hivelogout.dart';

class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({
    this.batchNo,
    this.email,
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  final String? batchNo;
  final String? email;
  final Map<String, dynamic> userDetails;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  String _appBarTitle = 'Home';

  @override
  Widget build(BuildContext context) {
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
        child: MenuDrawer(userDetails: widget.userDetails),
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
    switch (currentIndex) {
      case 0:
        return HomeScreen(userDetails: widget.userDetails);
      case 1:
        return const ProgressScreen();
      case 2:
        return ProfileScreen(
          batchNo: widget.batchNo,
          email: widget.email,
          
        );
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
  final Map<String, dynamic> userDetails;

  const MenuDrawer({Key? key, required this.userDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String studentName = userDetails['name'] ?? 'N/A';
    String domain = userDetails['domain'] ?? 'N/A';

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
              studentName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            accountEmail: Text(
              domain,
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
                studentName.isNotEmpty ? studentName[0] : 'A',
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
              print('logoutbuttonpressed');
              performLogout(context);
                await Hive.box('userDetails').close();

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
