import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_workout_card.dart';

class OneDayViewBody extends StatelessWidget {
  const OneDayViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAssessmentTextWidget(),
              SizedBox(height: height * 0.18),
              CustomWorkoutCard(
                title: 'Full Body Day',
                subtitle: 'Day 1',
                imagePath: 'assets/images/full body.png',

                onStart: () {},
              ),
              CustomButton(
                text: 'Continue',
                width: 100,
                height: 100,
                style: Styles.textStyle14,
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
