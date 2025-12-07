import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/workout/presentation/views/widgets/exercise_button.dart';

class WorkoutDetailsViewBody extends StatelessWidget {
  const WorkoutDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    // List of exercises
    final exercises = [
      'Lat pull down',
      'Dumbbell Row',
      'T_Bar',
      'Reverse Fly Machine',
      'Incline Curl Dumbbell',
      'Hammer Dumbbell',
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            CustomAssessmentTextWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/pull day.png',
                      width: double.infinity,
                      height: height * 0.26,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: height * 0.03),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pull Day',
                            style: Styles.textStyle30.copyWith(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: height * 0.002),
                          Text(
                            '6 Workouts',
                            style: Styles.textStyle18.copyWith(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF434B53),
                                borderRadius: BorderRadius.circular(19),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined, size: 25),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Schedule Workout',
                                    style: Styles.textStyle18.copyWith(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '3/5,09:30',
                                    style: Styles.textStyle16.copyWith(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_ios, size: 18),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            'Exercises',
                            style: Styles.textStyle24.copyWith(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: height * 0.015),
                          ...exercises.map(
                            (exercise) => ExerciseButton(
                              exerciseName: exercise,
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).push(AppRouter.kAboutWorkoutView);
                              },
                              imagePath: 'assets/images/workout.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
              text: 'Start Workout',
              width: 300,
              height: 56,
              style: Styles.textStyle20.copyWith(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
              radius: 19,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
