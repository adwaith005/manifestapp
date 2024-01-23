import 'package:flutter/material.dart';

class MyGradientBorderContainer extends StatelessWidget {
  final double width;
  final double height;

  MyGradientBorderContainer({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [Colors.red, Colors.orange, Colors.yellow],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.transparent, width: 5),
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}