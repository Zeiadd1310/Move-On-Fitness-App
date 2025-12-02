import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class ResetOptionCard extends StatelessWidget {
  final Color iconBg;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color icColor;

  const ResetOptionCard({
    super.key,
    required this.iconBg,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    required this.icColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: icColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),

            SizedBox(width: 16),

            // Text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Styles.textStyle18.copyWith(fontFamily: 'Work Sans'),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white54,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
