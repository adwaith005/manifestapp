import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themanifestapp/Admin/adminbatch.dart';
import 'package:themanifestapp/Admin/adminhome.dart';
import 'package:themanifestapp/Admin/adminprofile.dart';

class AdminBottomNavigationBar extends StatefulWidget {
  const AdminBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<AdminBottomNavigationBar> createState() =>
      _AdminBottomNavigationBarState();
}

class _AdminBottomNavigationBarState extends State<AdminBottomNavigationBar> {
  int _currentIndex = 0;
  String _appBarTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF4F6F6),
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              _appBarTitle,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
          automaticallyImplyLeading: false),
      body: _getBody(_currentIndex),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color(0xFFF4F6F6),
        items: const [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(icon: Icons.batch_prediction_sharp, title: 'Batches'),
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

  Widget _getBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const Adminhome();
      case 1:
        return const Batches();
      case 2:
        return const Adminprofile(); 
    }
    return Container();
  }

  void _updateAppBarTitle() {
    setState(() {
      _appBarTitle = _currentIndex == 0
          ? 'Home'
          : (_currentIndex == 1 ? 'Batches' : 'Profile');
    });
  }
}
