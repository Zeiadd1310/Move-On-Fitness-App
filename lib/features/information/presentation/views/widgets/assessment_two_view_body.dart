import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/information/presentation/views/widgets/custom_assessment_options_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';

class AssessmentTwoViewBody extends StatelessWidget {
  const AssessmentTwoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final spacing = responsive.heightPercent(0.04);
    final backButtonSize = responsive.iconSize(48);
    final titleFontSize = responsive.fontSize(24);
    final rowSpacing = responsive.spacing(12);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomBackButton(
                    width: backButtonSize,
                    height: backButtonSize,
                  ),
                  SizedBox(width: rowSpacing),
                  Text(
                    'Assessment',
                    style: Styles.textStyle24.copyWith(
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing),
              Expanded(
                child: CustomAssessmentOptionsWidget(
                  title: 'What\'s your fitness\ngoal/target?',
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
