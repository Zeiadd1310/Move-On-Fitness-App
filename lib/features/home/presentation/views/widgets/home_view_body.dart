import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/home/presentation/views/widgets/bottom_workout_card.dart';
import 'package:move_on/features/home/presentation/views/widgets/custom_workout_card_widget.dart';
import 'package:move_on/features/home/presentation/views/widgets/home_menu_item.dart';
import 'package:move_on/features/profile/presentation/widgets/profile_vertical_divider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.045,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Zeiad',
                          style: Styles.textStyle20.copyWith(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                          ),
                        ),
                        Text(
                          'It\'s time to challenge your limits.',
                          style: Styles.textStyle14.copyWith(
                            fontFamily: 'League Spartan',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            GoRouter.of(
                              context,
                            ).push(AppRouter.kNotificationSettingsView);
                          },
                          icon: const Icon(
                            Icons.notifications,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.kProfileView);
                          },
                          icon: const Icon(
                            Icons.person,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeMenuItem(
                      icon: Icons.fitness_center,
                      title: 'Workout',
                      onTap: () {},
                    ),
                    ProfileVerticalDivider(
                      color: kPrimaryColor,
                      height: 50,
                      width: 2,
                    ),
                    HomeMenuItem(
                      icon: FontAwesomeIcons.clipboardCheck,
                      title: 'Progress\nTracking',
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).push(AppRouter.kProgressTrackingView);
                      },
                    ),
                    ProfileVerticalDivider(
                      color: kPrimaryColor,
                      height: 50,
                      width: 2,
                    ),
                    HomeMenuItem(
                      icon: FontAwesomeIcons.appleWhole,
                      title: 'Nutrition',
                      onTap: () {},
                    ),
                    ProfileVerticalDivider(
                      color: kPrimaryColor,
                      height: 50,
                      width: 2,
                    ),
                    HomeMenuItem(
                      icon: FontAwesomeIcons.robot,
                      title: 'AI Chat',
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Recommendations',
                  style: Styles.textStyle20.copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                    fontSize: isSmallScreen ? 18 : 20,
                  ),
                ),
                SizedBox(height: screenHeight * 0.012),
                SizedBox(
                  height: isSmallScreen ? 200 : 220,
                  child: isSmallScreen
                      ? Column(
                          children: [
                            CustomWorkoutCardWidget(
                              title: 'Squat Exercise',
                              imagePath: 'assets/images/home1.png',
                              subTitle1: '12 Minutes',
                              subTitle2: '120 Kcal',
                              cardWidth: screenWidth * 0.9,
                            ),
                            SizedBox(height: 15),
                            CustomWorkoutCardWidget(
                              title: 'Full Body Stretching',
                              imagePath: 'assets/images/home2.png',
                              subTitle1: '12 Minutes',
                              subTitle2: '120 Kcal',
                              cardWidth: screenWidth * 0.9,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomWorkoutCardWidget(
                                title: 'Squat Exercise',
                                imagePath: 'assets/images/home1.png',
                                subTitle1: '12 Minutes',
                                subTitle2: '120 Kcal',
                                cardWidth: null,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Expanded(
                              child: CustomWorkoutCardWidget(
                                title: 'Full Body Stretching',
                                imagePath: 'assets/images/home2.png',
                                subTitle1: '12 Minutes',
                                subTitle2: '120 Kcal',
                                cardWidth: null,
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: isSmallScreen
                        ? Column(
                            children: [
                              Text(
                                'If when you look in the mirror you don\'t see the perfect version of yourself, you better see the hardest working version of yourself.',
                                style: Styles.textStyle14.copyWith(
                                  color: kPrimaryColor,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/home3.png',
                                  fit: BoxFit.cover,
                                  height: isSmallScreen ? 100 : 120,
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'If when you look in the mirror you don\'t see the perfect version of yourself, you better see the hardest working version of yourself.',
                                  style: Styles.textStyle14.copyWith(
                                    color: kPrimaryColor,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: isSmallScreen ? 12 : 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.012),
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/images/home3.png',
                                    fit: BoxFit.cover,
                                    height: isSmallScreen ? 100 : 120,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                isSmallScreen
                    ? Column(
                        children: [
                          BottomWorkoutCard(
                            icon: Icons.directions_run,
                            calories: '120 Kcal',
                            duration: 'Duration \n25 Mins',
                            date: 'June 09',
                            workoutType: 'Upper Body Workout',
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          BottomWorkoutCard(
                            icon: Icons.directions_run,
                            calories: '120 Kcal',
                            duration: 'Duration \n25 Mins',
                            date: 'June 09',
                            workoutType: 'Upper Body Workout',
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: BottomWorkoutCard(
                              icon: Icons.directions_run,
                              calories: '120 Kcal',
                              duration: 'Duration \n25 Mins',
                              date: 'June 09',
                              workoutType: 'Upper Body Workout',
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: BottomWorkoutCard(
                              icon: Icons.directions_run,
                              calories: '120 Kcal',
                              duration: 'Duration \n25 Mins',
                              date: 'June 09',
                              workoutType: 'Upper Body Workout',
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
