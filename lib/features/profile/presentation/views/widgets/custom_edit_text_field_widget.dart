import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';

class CustomEditTextFieldWidget extends StatelessWidget {
  const CustomEditTextFieldWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.38;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          text,
          style: Styles.textStyle18.copyWith(
            fontFamily: 'League Spartan',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: headerHeight * 0.02),
        CustomFormTextField(borderColor: Colors.white, width: 1.5),
      ],
    );
  }
}
