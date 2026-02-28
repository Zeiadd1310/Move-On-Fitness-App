import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_workout_card.dart';

class OneDayViewBody extends StatelessWidget {
  const OneDayViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final spacing = responsive.heightPercent(0.18);
    final buttonSize = responsive.buttonWidth(100);
    final buttonHeight = responsive.buttonHeight(100);
    final fontSize = responsive.fontSize(14);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAssessmentTextWidget(),
              SizedBox(height: spacing),
              CustomWorkoutCard(
                title: 'Full Body Day',
                subtitle: 'Day 1',
                imagePath: 'assets/images/full body.png',
                onStart: () {},
              ),
              CustomButton(
                text: 'Continue',
                width: buttonSize,
                height: buttonHeight,
                style: Styles.textStyle14.copyWith(fontSize: fontSize),
                radius: 15,
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kTwoDaysView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
