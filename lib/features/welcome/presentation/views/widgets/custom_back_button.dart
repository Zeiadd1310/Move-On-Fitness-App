import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onTap,
    this.iconColor = Colors.white,
    this.iconSize = 24.0,
    this.radius = 12.0,
  });

  final VoidCallback? onTap;
  final Color iconColor;
  final double iconSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },

      child: Container(
        width: 57.29,
        height: 56,
        decoration: BoxDecoration(
          color: kBackColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Icon(Icons.arrow_back, color: iconColor, size: iconSize),
        ),
      ),
    );
  }
}
