import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class CustomWorkoutCard extends StatelessWidget {
  const CustomWorkoutCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.onStart,
  });

  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback? onStart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 175,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 16,
                  bottom: 0,
                  child: Text(
                    "$title\n$subtitle",
                    style: Styles.textStyle18.copyWith(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(color: Color(0xFF2B2E33)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Workout Schedule',
                    style: Styles.textStyle16.copyWith(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomButton(
                    text: 'Start Now',
                    width: 144,
                    height: 40,
                    style: Styles.textStyle20.copyWith(
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w500,
                    ),
                    radius: 19,
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kWorkoutDetailsView);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
