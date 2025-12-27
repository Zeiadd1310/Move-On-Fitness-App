import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/home/presentation/views/widgets/home_menu_item.dart';
import 'package:move_on/features/profile/presentation/widgets/profile_vertical_divider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
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
                    ProfileVerticalDivider(color: kPrimaryColor),
                    HomeMenuItem(
                      icon: FontAwesomeIcons.clipboardCheck,
                      title: 'Progress\nTracking',
                      onTap: () {},
                    ),
                    ProfileVerticalDivider(color: kPrimaryColor),
                    HomeMenuItem(
                      icon: FontAwesomeIcons.appleWhole,
                      title: 'Nutrition',
                      onTap: () {},
                    ),
                    ProfileVerticalDivider(color: kPrimaryColor),
                    HomeMenuItem(
                      icon: Icons.person,
                      title: 'Profile',
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kProfileView);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
