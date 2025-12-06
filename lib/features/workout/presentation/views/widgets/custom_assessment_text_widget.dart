import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';

class CustomAssessmentTextWidget extends StatelessWidget {
  const CustomAssessmentTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.03,
      ),
      child: Row(
        children: [
          CustomBackButton(width: 48, height: 48),
          const SizedBox(width: 12),
          Text(
            'Assessment',
            style: Styles.textStyle24.copyWith(
              fontFamily: 'Work Sans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
