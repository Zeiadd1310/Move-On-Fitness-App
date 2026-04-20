import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/network_or_asset_image.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/information/data/models/workout_day_model.dart';
import 'package:move_on/features/workout/presentation/views/widgets/exercise_button.dart';

class WorkoutDetailsViewBody extends StatelessWidget {
  const WorkoutDetailsViewBody({super.key, required this.day});

  final WorkoutDay day;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final coverUrl = day.coverDisplayPath;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAssessmentTextWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    coverUrl.isNotEmpty
                        ? NetworkOrAssetImage(
                            path: coverUrl,
                            width: double.infinity,
                            height: height * 0.26,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'assets/images/workout.png',
                              width: double.infinity,
                              height: height * 0.26,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            'assets/images/workout.png',
                            width: double.infinity,
                            height: height * 0.26,
                            fit: BoxFit.cover,
                          ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            day.dayType,
                            style: Styles.textStyle24.copyWith(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: height * 0.002),
                          Text(
                            '${day.exercises.length} Workouts',
                            style: Styles.textStyle16.copyWith(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Color(0xffF2F2F2),
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          Container(
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
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  size: 25,
                                ),
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
                                  day.dayKey.toUpperCase(),
                                  style: Styles.textStyle16.copyWith(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_ios, size: 18),
                              ],
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
                          ...day.exercises.map(
                            (exercise) => ExerciseButton(
                              exerciseName: exercise.exerciseName,
                              imagePath: exercise.imageUrl,
                              onTap: () {
                                GoRouter.of(context).push(
                                  AppRouter.kAboutWorkoutView,
                                  extra: {
                                    'dayType': day.dayType,
                                    'exercise': exercise,
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: CustomButton(
                  text: 'Start Workout',
                  width: 265,
                  height: 50,
                  style: Styles.textStyle20.copyWith(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                  ),
                  radius: 26,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
