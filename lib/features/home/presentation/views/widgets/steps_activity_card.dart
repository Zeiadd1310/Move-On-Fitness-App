import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_vertical_divider.dart';

class StepsActivityCard extends StatelessWidget {
  final String day;
  final String date;
  final String steps;
  final String duration;

  const StepsActivityCard({
    super.key,
    required this.day,
    required this.date,
    required this.steps,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.only(
        left: isSmallScreen ? 20 : 24,
        right: isSmallScreen ? 12 : 18,
        top: isSmallScreen ? 10 : 12,
        bottom: isSmallScreen ? 10 : 12,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 20 : 25,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          SizedBox(width: 30),
          ProfileVerticalDivider(color: Colors.white, height: 50, width: 2),
          SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Steps',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(width: 80),
                  Text(
                    'Duration',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    steps,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 22 : 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(width: 40),
                  const Icon(
                    Icons.access_time_filled,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 22 : 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
