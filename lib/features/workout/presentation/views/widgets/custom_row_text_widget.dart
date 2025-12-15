import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class CustomRowTextWidget extends StatelessWidget {
  const CustomRowTextWidget({
    super.key,
    required this.textLeft,
    required this.textRight,
  });
  final String textLeft;
  final String textRight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              textLeft,
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Expanded(
            child: Text(
              textRight,
              textAlign: TextAlign.left,
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
