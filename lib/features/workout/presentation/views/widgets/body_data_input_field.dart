import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class BodyDataInputField extends StatelessWidget {
  const BodyDataInputField({
    super.key,
    required this.controller,
    required this.width,
  });

  final TextEditingController controller;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF2B2E33),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: Styles.textStyle30.copyWith(
            fontFamily: 'Work Sans',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ),
    );
  }
}
