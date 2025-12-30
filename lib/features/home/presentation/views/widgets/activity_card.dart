import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final IconData icon2;
  final String calories;
  final String workoutType;
  final String date;
  final String duration;

  const ActivityCard({
    super.key,
    required this.icon,
    required this.calories,
    required this.workoutType,
    required this.date,
    required this.duration,
    required this.icon2,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      child: Row(
        children: [
          Container(
            width: isSmallScreen ? 60 : 70,
            height: isSmallScreen ? 60 : 70,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: isSmallScreen ? 40 : 60,
            ),
          ),
          SizedBox(width: isSmallScreen ? 8 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon2,
                      color: kPrimaryColor,
                      size: isSmallScreen ? 10 : 15,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      calories,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmallScreen ? 12 : 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'League Spartan',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  workoutType,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: isSmallScreen ? 12 : 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Duration',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_filled,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
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
