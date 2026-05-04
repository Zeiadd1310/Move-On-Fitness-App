import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';

class BottomWorkoutCard extends StatelessWidget {
  final IconData icon;
  final String workoutCount;
  final String duration;
  final String workoutType;

  const BottomWorkoutCard({
    super.key,
    required this.icon,
    required this.workoutCount,
    required this.duration,
    required this.workoutType,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 1),
      ),
      padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: isSmallScreen ? 40 : 60,
                height: isSmallScreen ? 40 : 60,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: isSmallScreen ? 30 : 40,
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
                          Icons.checklist,
                          color: kPrimaryColor,
                          size: isSmallScreen ? 20 : 30,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            workoutCount,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: isSmallScreen ? 14 : 18,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: kPrimaryColor,
                          size: isSmallScreen ? 20 : 30,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            duration,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: isSmallScreen ? 14 : 18,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            workoutType,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: isSmallScreen ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
