import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    required this.width,
    required this.height,
    required this.style,
    required this.radius,
    this.icon,
  });

  final VoidCallback? onTap;
  final String text;
  final double width;
  final double height;
  final TextStyle style;
  final double radius;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: style),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, color: Colors.white, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
