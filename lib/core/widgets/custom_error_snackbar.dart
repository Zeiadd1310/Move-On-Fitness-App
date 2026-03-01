import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class CustomErrorSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
  final double? width = 360;
  final double? height = 60;

  const CustomErrorSnackBar({
    super.key,
    required this.message,
    this.backgroundColor = const Color(0xFF450A0A),
    this.borderColor = const Color(0xffEF4444),
    this.icon = Icons.error_outline,
  });

  /// يعرض رسالة خطأ بتصميم الـ app (استخدمها في الـ listener بدل SnackBar العادي)
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomErrorSnackBar(message: message),
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
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Styles.textStyle16.copyWith(
                fontFamily: 'Work Sans',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
