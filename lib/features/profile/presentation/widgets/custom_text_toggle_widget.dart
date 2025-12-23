import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/profile/presentation/widgets/custom_toggle.dart';

class CustomTextToggleWidget extends StatelessWidget {
  const CustomTextToggleWidget({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Styles.textStyle20.copyWith(
            fontFamily: 'League Spartan',
            fontWeight: FontWeight.w700,
          ),
        ),
        CustomToggle(),
      ],
    );
  }
}
