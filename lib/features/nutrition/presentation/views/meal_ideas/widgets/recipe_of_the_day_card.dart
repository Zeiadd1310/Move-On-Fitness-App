import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';

class RecipeOfTheDayCard extends StatelessWidget {
  final MealType mealType;

  const RecipeOfTheDayCard({super.key, this.mealType = MealType.breakfast});

  Map<String, String> _getMealData() {
    switch (mealType) {
      case MealType.breakfast:
        return {
          'title': 'Spinach And Tomato Omelette',
          'time': '10 Minutes',
          'calories': '220 Cal',
          'image': 'assets/images/nutiration meal.png',
        };
      case MealType.lunch:
        return {
          'title': 'Grilled Chicken Salad',
          'time': '15 Minutes',
          'calories': '350 Cal',
          'image': 'assets/images/nutiration meal.png',
        };
      case MealType.dinner:
        return {
          'title': 'Salmon with Vegetables',
          'time': '25 Minutes',
          'calories': '420 Cal',
          'image': 'assets/images/nutiration meal.png',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealData = _getMealData();

    return Container(
      height: 275,
      color: kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                mealData['image']!,
                height: 235,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade800,
                    child: const Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              // Recipe Of The Day badge
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Recipe Of The Day',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              // Bottom overlay with shadow
              Positioned(
                top: 170,
                bottom: -6,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff212020).withOpacity(0.9),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 10,
                    top: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mealData['title']!,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            Shadow(
                              offset: const Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time_filled, size: 15),
                          SizedBox(width: 4),
                          Text(
                            '${mealData['time']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'League Spartan',
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(FontAwesomeIcons.fire, size: 15),
                          SizedBox(width: 4),
                          Text(
                            '${mealData['calories']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'League Spartan',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
