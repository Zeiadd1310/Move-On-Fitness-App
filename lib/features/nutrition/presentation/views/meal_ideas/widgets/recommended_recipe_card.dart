import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';

// #region agent log
void _log(
  String location,
  String message,
  Map<String, dynamic> data,
  String hypothesisId,
) {
  try {
    final logEntry = jsonEncode({
      'sessionId': 'debug-session',
      'runId': 'run1',
      'hypothesisId': hypothesisId,
      'location': location,
      'message': message,
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
    File(
      r'd:\Uni\Graduation\MoveOn\move_on\.cursor\debug.log',
    ).writeAsStringSync('$logEntry\n', mode: FileMode.append);
  } catch (_) {}
}
// #endregion

class RecommendedRecipeCard extends StatelessWidget {
  final MealType mealType;
  final int index;

  const RecommendedRecipeCard({
    super.key,
    this.mealType = MealType.breakfast,
    this.index = 0,
  });

  Map<String, String> _getRecipeData() {
    switch (mealType) {
      case MealType.breakfast:
        final breakfastRecipes = [
          {'title': 'Fruit Smoothie', 'time': '12', 'cal': '120'},
          {'title': 'Oatmeal Bowl', 'time': '8', 'cal': '180'},
        ];
        return breakfastRecipes[index % breakfastRecipes.length];
      case MealType.lunch:
        final lunchRecipes = [
          {'title': 'Chicken Wrap', 'time': '15', 'cal': '320'},
          {'title': 'Quinoa Salad', 'time': '20', 'cal': '280'},
        ];
        return lunchRecipes[index % lunchRecipes.length];
      case MealType.dinner:
        final dinnerRecipes = [
          {'title': 'Grilled Fish', 'time': '25', 'cal': '380'},
          {'title': 'Pasta Primavera', 'time': '18', 'cal': '350'},
        ];
        return dinnerRecipes[index % dinnerRecipes.length];
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipeData = _getRecipeData();

    // #region agent log
    _log(
      'recommended_recipe_card.dart:25',
      'RecommendedRecipeCard build started',
      {'widgetType': 'RecommendedRecipeCard', 'mealType': mealType.toString()},
      'A',
    );
    // #endregion
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.grey.shade900,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.asset(
              'assets/images/recommended 1.png',
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // #region agent log
                _log('recommended_recipe_card.dart:30', 'Image.asset error', {
                  'error': error.toString(),
                  'asset': 'assets/images/recommended 2.png',
                }, 'B');
                // #endregion
                return Container(
                  color: Colors.grey,
                  height: 110,
                  width: double.infinity,
                );
              },
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipeData['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      size: 14,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${recipeData['time']} Minutes',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      FontAwesomeIcons.fire,
                      size: 14,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${recipeData['cal']} Cal',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
