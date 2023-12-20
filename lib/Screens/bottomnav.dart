// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Screens/home.dart';
import 'package:themanifestapp/Screens/login.dart';
import 'package:themanifestapp/Screens/profile.dart';
import 'package:themanifestapp/Screens/progress.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

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
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF202628),
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
            color: Colors.black,
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
        activeColor: Colors.black, // Color for the active icon
        color: Colors.grey, // C
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
  const Menudrawer({Key? key});

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
              'User name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              'User@gmail.com',
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
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
