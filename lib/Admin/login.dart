import 'package:flutter/material.dart';
import 'package:themanifestapp/widgets/adminlogin.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({Key? key}) : super(key: key);

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
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
              
                ? MediaQuery.of(context).size.height / 4.5
                : MediaQuery.of(context).size.height / 4,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: isSmallScreen ? 110 : 80,
                      right: isSmallScreen ? 60 : 80,
                    ),
                    child: Image.asset(
                      'lib/images/logoin.png',
                      height: isSmallScreen ? 50 : 80,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: isSmallScreen
                ? MediaQuery.of(context).size.height / 4
                : MediaQuery.of(context).size.height / 4.3,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                decoration: const  BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: const  AdminLoginForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
