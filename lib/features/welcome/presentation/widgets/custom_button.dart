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
  });

  final VoidCallback? onTap;
  final String text;
  final double width;
  final double height;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(child: Text(text, style: style)),
      ),
    );
  }
}
