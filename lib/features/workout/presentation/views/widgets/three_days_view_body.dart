import 'package:flutter/material.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_workout_card.dart';

class ThreeDaysViewBody extends StatelessWidget {
  const ThreeDaysViewBody({super.key});

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
                title: 'Push Day',
                subtitle: 'Day 1',
                imagePath: 'assets/images/push day.png',

                onStart: () {},
              ),
              SizedBox(height: height * 0.01),
              CustomWorkoutCard(
                title: 'Pull Day',
                subtitle: 'Day 2',
                imagePath: 'assets/images/pull day.png',
                onStart: () {},
              ),
              SizedBox(height: height * 0.01),
              CustomWorkoutCard(
                title: 'Leg Day',
                subtitle: 'Day 3',
                imagePath: 'assets/images/leg day.png',
                onStart: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
