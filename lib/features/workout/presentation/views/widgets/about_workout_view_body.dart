import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/features/information/data/models/workout_excersice_model.dart';

class AboutWorkoutViewBody extends StatelessWidget {
  const AboutWorkoutViewBody({
    super.key,
    required this.exercise,
    required this.dayType,
  });

  final WorkoutExercise exercise;
  final String dayType;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final horizontalPadding = width * 0.03;
    final verticalPadding = height * 0.01;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAssessmentTextWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    exercise.imageUrl.isNotEmpty
                        ? Image.network(
                            exercise.imageUrl,
                            width: double.infinity,
                            height: height * 0.26,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'assets/images/chestpressdark.png',
                              width: double.infinity,
                              height: height * 0.26,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            'assets/images/chestpressdark.png',
                            width: double.infinity,
                            height: height * 0.26,
                            fit: BoxFit.cover,
                          ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.02),
                          Text(
                            exercise.exerciseName,
                            style: Styles.textStyle24.copyWith(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            '01 workout in $dayType',
                            style: Styles.textStyle16.copyWith(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor,
                            ),
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            'Sets: ${exercise.sets}       Reps: ${exercise.reps}',
                            style: Styles.textStyle20.copyWith(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: height * 0.025),
                          Text(
                            exercise.description.isEmpty
                                ? 'No description available for this exercise.'
                                : exercise.description,
                            style: Styles.textStyle16.copyWith(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                              height: 1.1,
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          if (exercise.videoUrl.isNotEmpty)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  GoRouter.of(context).push(
                                    AppRouter.kWorkoutVideoView,
                                    extra: {
                                      'videoUrl': exercise.videoUrl,
                                      'title': exercise.exerciseName,
                                    },
                                  );
                                },
                                icon: const Icon(Icons.play_circle_fill),
                                label: const Text('Watch Exercise Video'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
