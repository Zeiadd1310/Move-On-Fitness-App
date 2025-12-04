import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/information/presentation/views/widgets/custom_assessment_options_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';

class AssessmentTwoViewBody extends StatelessWidget {
  const AssessmentTwoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              SizedBox(height: height * 0.04),
              Expanded(
                child: CustomAssessmentOptionsWidget(
                  title: 'What’s your fitness\ngoal/target?',
                  subtitle: 'This helps us create your personalized plan',
                  options: const [
                    'Lose Weight',
                    'Gain Muscle',
                    'Gain Muscles and Lose Weight',
                  ],
                  nextRoute: AppRouter.kAssessmentThreeView,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
