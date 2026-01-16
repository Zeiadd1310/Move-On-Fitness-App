import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/features/home/presentation/views/widgets/custom_workout_card_widget.dart';
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

class RecommendedSection extends StatelessWidget {
  final MealType mealType;

  const RecommendedSection({super.key, this.mealType = MealType.breakfast});

  Map<String, String> _getRecipeData(int index) {
    // Different images for each card - ensure each card has a unique image
    final images = [
      'assets/images/recommended 1.png',
      'assets/images/recommended 2.png',
      'assets/images/home1.png',
      'assets/images/home2.png',
    ];

    switch (mealType) {
      case MealType.breakfast:
        final breakfastRecipes = [
          {
            'title': 'Fruit Smoothie',
            'time': '12 Minutes',
            'cal': '120 Kcal',
            'image': images[0], // First image for first card
          },
          {
            'title': 'Oatmeal Bowl',
            'time': '8 Minutes',
            'cal': '180 Kcal',
            'image': images[1], // Second image for second card
          },
        ];
        return breakfastRecipes[index % breakfastRecipes.length];
      case MealType.lunch:
        final lunchRecipes = [
          {
            'title': 'Chicken Wrap',
            'time': '15 Minutes',
            'cal': '320 Kcal',
            'image': images[2], // Third image for first card
          },
          {
            'title': 'Quinoa Salad',
            'time': '20 Minutes',
            'cal': '280 Kcal',
            'image': images[3], // Fourth image for second card
          },
        ];
        return lunchRecipes[index % lunchRecipes.length];
      case MealType.dinner:
        final dinnerRecipes = [
          {
            'title': 'Grilled Fish',
            'time': '25 Minutes',
            'cal': '380 Kcal',
            'image': images[0], // Different image for first card
          },
          {
            'title': 'Pasta Primavera',
            'time': '18 Minutes',
            'cal': '350 Kcal',
            'image': images[1], // Different image for second card
          },
        ];
        return dinnerRecipes[index % dinnerRecipes.length];
    }
  }

  @override
  Widget build(BuildContext context) {
    // #region agent log
    _log('recommended_section.dart:91', 'RecommendedSection build started', {
      'mealType': mealType.toString(),
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }, 'A');
    // #endregion
    return Column(
      key: ValueKey('recommended_$mealType'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recommended',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 180,
          child: ListView.separated(
            key: ValueKey('recommended_list_$mealType'),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final recipeData = _getRecipeData(index);
              // #region agent log
              _log('recommended_section.dart:121', 'Building recipe card', {
                'index': index,
                'title': recipeData['title'],
                'mealType': mealType.toString(),
              }, 'B');
              // #endregion
              return CustomWorkoutCardWidget(
                key: ValueKey('recipe_${mealType}_$index'),
                title: recipeData['title']!,
                imagePath: recipeData['image']!,
                subTitle1: recipeData['time']!,
                subTitle2: recipeData['cal']!,
                cardWidth: null,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemCount: 2,
          ),
        ),
      ],
    );
  }
}
