import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipe_image_with_badge.dart';

class RecipeOfTheDayCard extends StatelessWidget {
  final MealType mealType;

  const RecipeOfTheDayCard({super.key, this.mealType = MealType.breakfast});

  Map<String, dynamic> _getMealData() {
    switch (mealType) {
      case MealType.breakfast:
        return {
          'title': 'Spinach And Tomato Omelette',
          'time': '10',
          'calories': '220 Cal',
          'image': 'assets/images/nutiration meal.png',
          'ingredients': [
            '2-3 eggs',
            'A handful of fresh spinach',
            '1 small tomato',
            'Salt and pepper to taste',
            'Olive oil or butter',
          ],
          'preparation':
              'Beat the eggs in a bowl. Heat olive oil in a non-stick pan. Add spinach and tomato, sauté briefly. Pour in eggs and cook until set. Season with salt and pepper. Fold and serve.',
          'mealType': mealType,
          'isRecipeOfTheDay': true,
        };
      case MealType.lunch:
        return {
          'title': 'Grilled Chicken Salad',
          'time': '15',
          'calories': '350 Cal',
          'image': 'assets/images/nutiration meal.png',
          'ingredients': [
            'Chicken breast',
            'Mixed greens',
            'Cherry tomatoes',
            'Cucumber',
            'Olive oil and lemon juice',
          ],
          'preparation':
              'Grill the chicken breast until cooked through. Chop vegetables and mix with greens. Slice chicken and place on top. Drizzle with olive oil and lemon juice. Toss and serve.',
          'mealType': mealType,
          'isRecipeOfTheDay': true,
        };
      case MealType.dinner:
        return {
          'title': 'Salmon with Vegetables',
          'time': '25',
          'calories': '420 Cal',
          'image': 'assets/images/nutiration meal.png',
          'ingredients': [
            'Salmon fillet',
            'Broccoli and carrots',
            'Garlic and herbs',
            'Olive oil',
            'Lemon',
          ],
          'preparation':
              'Season the salmon with herbs. Roast vegetables with olive oil. Pan-sear salmon until golden. Serve with lemon wedges and roasted vegetables.',
          'mealType': mealType,
          'isRecipeOfTheDay': true,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealData = _getMealData();
    final timeStr = mealData['time'].toString().contains('Minutes')
        ? mealData['time']
        : '${mealData['time']} Minutes';

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kRecipeDetailView, extra: mealData);
      },
      child: Stack(
        children: [
          RecipeImageWithBadge(
            imagePath: mealData['image']!,
            showBadge: true,
            badgePosition: Alignment.topRight,
            containerHeight: 275,
            imageHeight: 235,
            hasPadding: true,
          ),
          // Bottom overlay with shadow
          Positioned(
            top: 170,
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
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
                        timeStr,
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
    );
  }
}
