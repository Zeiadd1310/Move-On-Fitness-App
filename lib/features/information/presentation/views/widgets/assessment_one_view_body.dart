import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class AssessmentOneViewBody extends StatelessWidget {
  const AssessmentOneViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 80),
            child: Row(
              children: [
                CustomBackButton(width: 48, height: 48),
                SizedBox(width: 12),
                Text(
                  'Assessment',
                  style: Styles.textStyle24.copyWith(
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Text(
            textAlign: TextAlign.center,
            'Your Regular Physical Activity Level ?',
            style: Styles.textStyle30.copyWith(fontFamily: 'Work Sans'),
          ),
          SizedBox(height: 50),
          Text(
            textAlign: TextAlign.center,
            'This helps us create your personalized plan',
            style: Styles.textStyle16.copyWith(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 30),
          SizedBox(height: 50),
          CustomButton(
            text: 'Continue ',
            width: 343,
            height: 56,
            style: Styles.textStyle16,
            radius: 19,
          ),
        ],
      ),
    );
  }
}
