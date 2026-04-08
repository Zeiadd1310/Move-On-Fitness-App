import 'package:flutter/material.dart';

import 'package:move_on/core/utils/helpers/responsive_helper.dart';

import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_workout_card.dart';

class OneDayViewBody extends StatelessWidget {
  const OneDayViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final spacing = responsive.heightPercent(0.18);

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
            ],
          ),
        ),
      ),
    );
  }
}
