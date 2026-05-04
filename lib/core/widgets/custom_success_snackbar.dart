import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class CustomSuccessSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color borderColor;
  final double? width = 380;
  final double? height = 80;

  const CustomSuccessSnackBar({
    super.key,
    required this.message,
    this.backgroundColor = const Color(0xFF052E16),
    this.borderColor = const Color(0xFF22C55E),
  });

  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomSuccessSnackBar(message: message),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Expanded(
        child: Text(
          message,
          style: Styles.textStyle16.copyWith(
            fontFamily: 'Work Sans',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
