import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_workout_card.dart';

class FiveDaysViewBody extends StatelessWidget {
  const FiveDaysViewBody({super.key});

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
              CustomWorkoutCard(
                title: 'Chest Day',
                subtitle: 'Day 1',
                imagePath: 'assets/images/chest.png',

                onStart: () {},
              ),
              SizedBox(height: height * 0.03),
              CustomWorkoutCard(
                title: 'Back Day',
                subtitle: 'Day 2',
                imagePath: 'assets/images/back.png',
                onStart: () {},
              ),
              SizedBox(height: height * 0.03),
              CustomWorkoutCard(
                title: 'Shoulder Day',
                subtitle: 'Day 3',
                imagePath: 'assets/images/shoulder.png',
                onStart: () {},
              ),
              SizedBox(height: height * 0.03),
              CustomWorkoutCard(
                title: 'Arms Day',
                subtitle: 'Day 4',
                imagePath: 'assets/images/arms.png',
                onStart: () {},
              ),
              SizedBox(height: height * 0.03),
              CustomWorkoutCard(
                title: 'Leg and Abs',
                subtitle: 'Day 5',
                imagePath: 'assets/images/leg and abs.png',
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
                  GoRouter.of(context).push(AppRouter.kFiveDaysView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
