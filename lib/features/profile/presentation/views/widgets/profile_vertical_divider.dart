import 'package:flutter/material.dart';

class ProfileVerticalDivider extends StatelessWidget {
  const ProfileVerticalDivider({
    super.key,
    required this.color,
    required this.height,
    required this.width,
    this.radius,
  });

  final Color color;
  final double height;
  final double width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
        color: color,
      ),
    );
  }
}
