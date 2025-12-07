import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';

class AboutWorkoutViewBody extends StatelessWidget {
  const AboutWorkoutViewBody({super.key});

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
                    Image.asset(
                      'assets/images/leg day.png',
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
                            'Lat Pull Down',
                            style: Styles.textStyle24.copyWith(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            '01 Workouts in pull Day',
                            style: Styles.textStyle16.copyWith(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor,
                            ),
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            'Sets: 3       Reps: 12',
                            style: Styles.textStyle20.copyWith(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: height * 0.025),
                          Text(
                            'The Lat Pull Down is a strength training exercise that targets the latissimus dorsi, the large muscles of your back.\n\nSit on the machine with your thighs secured under the pads. Grasp the bar with a wide overhand grip, then pull it down toward your upper chest while keeping your back straight and your chest lifted.\n\nPause briefly at the bottom of the movement, then slowly return the bar to the starting position.\n\nFocus on controlled motion and avoid swinging your body.',
                            style: Styles.textStyle16.copyWith(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                              height: 1.1,
                            ),
                          ),
                          SizedBox(height: height * 0.02),
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
