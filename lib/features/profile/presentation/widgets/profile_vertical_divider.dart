import 'package:flutter/material.dart';

class ProfileVerticalDivider extends StatelessWidget {
  const ProfileVerticalDivider({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(height: 50, width: 2, color: color);
  }
}
