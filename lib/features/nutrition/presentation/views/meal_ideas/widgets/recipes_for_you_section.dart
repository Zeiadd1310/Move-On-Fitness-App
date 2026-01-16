import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipe_list_card.dart';
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

class RecipesForYouSection extends StatelessWidget {
  final MealType mealType;

  const RecipesForYouSection({super.key, this.mealType = MealType.breakfast});

  @override
  Widget build(BuildContext context) {
    // #region agent log
    _log(
      'recipes_for_you_section.dart:15',
      'RecipesForYouSection build started',
      {},
      'A',
    );
    // #endregion
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recipes For You',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          RecipeListCard(mealType: mealType, index: 0),
          const SizedBox(height: 12),
          RecipeListCard(mealType: mealType, index: 1),
        ],
      ),
    );
  }
}
