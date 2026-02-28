import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;

  const SocialIcon({
    super.key,
    required this.icon,
    this.size = 60,
    this.iconSize = 24,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
        ),
        child: Center(
          child: Icon(icon, size: iconSize, color: Colors.white),
        ),
      ),
    );
  }
}
