import 'package:flutter/material.dart';

class LongPressDetectorWidget extends StatelessWidget {
  final VoidCallback onLongPress;
  final Widget child;

  const LongPressDetectorWidget({super.key, 
    required this.onLongPress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: child,
    );
  }
}
