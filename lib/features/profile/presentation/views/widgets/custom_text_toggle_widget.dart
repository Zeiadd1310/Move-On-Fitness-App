import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/profile/presentation/views/widgets/custom_toggle.dart';

class CustomTextToggleWidget extends StatelessWidget {
  const CustomTextToggleWidget({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;
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
        CustomToggle(value: value, onChanged: onChanged),
      ],
    );
  }
}
