import 'package:flutter/material.dart';

class ProgressScreen extends StatefulWidget {
 final String uid;

  const ProgressScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
