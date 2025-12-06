import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_workout_card.dart';

class TwoDaysViewBody extends StatelessWidget {
  const TwoDaysViewBody({super.key});

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
              SizedBox(height: height * 0.06),
              CustomWorkoutCard(
                title: 'Upper Body',
                subtitle: 'Day 1',
                imagePath: 'assets/images/upper body.png',

                onStart: () {},
              ),
              SizedBox(height: height * 0.03),
              CustomWorkoutCard(
                title: 'Lower Body',
                subtitle: 'Day 2',
                imagePath: 'assets/images/lower body.png',

                onStart: () {},
              ),
              SizedBox(height: height * 0.06),
              CustomButton(
                text: 'Continue',
                width: 60,
                height: 60,
                style: Styles.textStyle14,
                radius: 15,
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kThreeDaysView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
