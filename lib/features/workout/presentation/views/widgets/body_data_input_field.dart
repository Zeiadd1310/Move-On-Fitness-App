import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class BodyDataInputField extends StatelessWidget {
  const BodyDataInputField({
    super.key,
    required this.controller,
    required this.width,
    this.hintText = '0',
  });

  final TextEditingController controller;
  final double width;
  final String hintText;

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
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textAlign: TextAlign.center,
          style: Styles.textStyle30.copyWith(
            fontFamily: 'Work Sans',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: Styles.textStyle30.copyWith(
              fontFamily: 'Work Sans',
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.bold,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),
      ),
    );
  }
}
