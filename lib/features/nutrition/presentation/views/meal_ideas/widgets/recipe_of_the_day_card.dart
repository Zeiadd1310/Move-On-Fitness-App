import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipe_image_with_badge.dart';

class RecipeOfTheDayCard extends StatelessWidget {
  final MealType mealType;
  final List<Map<String, dynamic>> recipes;

  const RecipeOfTheDayCard({
    super.key,
    this.mealType = MealType.breakfast,
    this.recipes = const [],
  });

  @override
  Widget build(BuildContext context) {
    final mealData = {
      ...(recipes.isNotEmpty
          ? recipes.first
          : {
              'title': 'Recipe',
              'time': '10',
              'calories': '0 Cal',
              'image': 'assets/images/nutiration meal.png',
              'ingredients': const <String>[],
              'preparation': 'No preparation steps available.',
              'mealType': mealType,
            }),
      'isRecipeOfTheDay': true,
    };
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
                    const Color(0xff212020).withValues(alpha: 0.9),
                    Colors.black.withValues(alpha: 0.7),
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
                mainAxisSize: MainAxisSize.min,
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
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                        Shadow(
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black.withValues(alpha: 0.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time_filled, size: 15),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          timeStr,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(FontAwesomeIcons.fire, size: 15),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${mealData['calories']}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'League Spartan',
                          ),
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
