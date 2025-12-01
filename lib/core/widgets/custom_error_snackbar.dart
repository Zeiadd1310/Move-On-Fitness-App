import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class CustomErrorSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final IconData icon;
  final double? width;
  final double? height;

  const CustomErrorSnackBar({
    super.key,
    required this.message,
    this.backgroundColor = const Color(0xFF450A0A),
    this.icon = Icons.error_outline,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Styles.textStyle14.copyWith(fontFamily: 'Work Sans'),
            ),
          ),
        ],
      ),
    );
  }
}
