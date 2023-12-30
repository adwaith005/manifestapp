// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Screens/home.dart';
import 'package:themanifestapp/Screens/profile.dart';
import 'package:themanifestapp/Screens/progress.dart';
import 'package:themanifestapp/db/hivelogout.dart';

// ignore: must_be_immutable
class bottomNavigationBar extends StatefulWidget {
  bottomNavigationBar({
    String? batchNo,
    String? email,
    Key? key,
    required Map<String, dynamic> userDetails,
  })  : batchNo = batchNo,
        email = email,
        userDetails = userDetails,
        super(key: key);

  final String? batchNo;
  final String? email;
  final Map<String, dynamic> userDetails;

  @override
  State<bottomNavigationBar> createState() => _HomeState();
}

class _HomeState extends State<bottomNavigationBar> {
  int _currentIndex = 0;
  String _appBarTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _currentIndex == 2 ? Colors.black : Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: _currentIndex == 2 ? Colors.white : Color(0xFF202628),
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            );
          },
        ),
        automaticallyImplyLeading: false,
        title: Text(
          _appBarTitle,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: _currentIndex == 2 ? Colors.white : Color(0xFF202628),
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      drawer: const Menudrawer(),
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
        return const HomeScreen();
      case 1:
        return const ProgressScreen();
      case 2:
        return const ProfileScreen();
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

class Menudrawer extends StatelessWidget {
  final String? batchNo;
  final String? email;

  const Menudrawer({Key? key, this.batchNo, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF202628),
            ),
            accountName: Text(
              'User name', // Replace with actual user name
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              'User@gmail.com', // Replace with actual user email
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          
          // Additional ListTile for Profile
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    batchNo: batchNo,
                    email: email,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
