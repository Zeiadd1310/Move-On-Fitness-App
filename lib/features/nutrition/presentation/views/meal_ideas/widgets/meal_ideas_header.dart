import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';

class MealIdeasHeader extends StatelessWidget {
  const MealIdeasHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing based on screen width
    final padding = screenWidth * 0.04; // 4% of screen width
    final iconSize = screenWidth * 0.075; // 7.5% of screen width
    final backIconSize = screenWidth * 0.0625; // 6.25% of screen width
    final fontSize = screenWidth * 0.06; // 6% of screen width
    final spacing = screenWidth * 0.01; // 1% of screen width

    // Clamp values for better UX on very small/large screens
    final clampedPadding = padding.clamp(12.0, 20.0);
    final clampedIconSize = iconSize.clamp(24.0, 30.0);
    final clampedBackIconSize = backIconSize.clamp(20.0, 28.0);
    final clampedFontSize = fontSize.clamp(16.0, 24.0);
    final clampedSpacing = spacing.clamp(0.0, 6.0);

    return Padding(
      padding: EdgeInsets.all(clampedPadding),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: clampedBackIconSize,
            ),
          ),
          SizedBox(width: clampedSpacing),
          Expanded(
            child: Text(
              'Meal Ideas',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: clampedFontSize,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(width: clampedSpacing),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              // Search functionality can be added here
            },
            icon: Icon(
              Icons.search,
              color: kPrimaryColor,
              size: clampedIconSize,
            ),
          ),
          SizedBox(width: clampedSpacing),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kNotificationSettingsView);
            },
            icon: Icon(
              Icons.notifications,
              color: kPrimaryColor,
              size: clampedIconSize,
            ),
          ),
          SizedBox(width: clampedSpacing),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kProfileView);
            },
            icon: Icon(
              Icons.person,
              color: kPrimaryColor,
              size: clampedIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
