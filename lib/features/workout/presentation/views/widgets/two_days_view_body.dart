import 'package:flutter/material.dart';

import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
