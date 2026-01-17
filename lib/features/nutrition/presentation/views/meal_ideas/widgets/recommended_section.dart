import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
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

  Map<String, dynamic> _getRecipeData(int index) {
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
            'time': '12',
            'cal': '120 Cal',
            'image': images[0],
            'ingredients': [
              '1/2 cup plain Greek yogurt',
              '1/2 cup almond milk or your favorite milk',
              'Honey or maple syrup (optional, to sweeten to taste)',
            ],
            'preparation':
                'Add all ingredients to a blender. Blend until smooth. Pour into a glass and serve. Add ice if desired.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
          {
            'title': 'Oatmeal Bowl',
            'time': '8',
            'cal': '180 Cal',
            'image': images[1],
            'ingredients': [
              'Rolled oats',
              'Milk or water',
              'Banana',
              'Cinnamon',
              'Nuts or seeds',
            ],
            'preparation':
                'Cook oats with milk or water. Top with sliced banana, cinnamon, and nuts. Serve warm.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
        ];
        return breakfastRecipes[index % breakfastRecipes.length];
      case MealType.lunch:
        final lunchRecipes = [
          {
            'title': 'Chicken Wrap',
            'time': '15',
            'cal': '320 Cal',
            'image': images[2],
            'ingredients': [
              'Tortilla',
              'Grilled chicken',
              'Lettuce',
              'Tomato',
              'Sauce of choice',
            ],
            'preparation':
                'Lay tortilla flat. Layer with chicken, lettuce, tomato, and sauce. Roll tightly and serve.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
          {
            'title': 'Quinoa Salad',
            'time': '20',
            'cal': '280 Cal',
            'image': images[3],
            'ingredients': [
              'Quinoa',
              'Cucumber',
              'Tomato',
              'Feta',
              'Olive oil',
              'Lemon',
            ],
            'preparation':
                'Cook quinoa and let cool. Mix with diced vegetables and feta. Drizzle with olive oil and lemon. Toss and serve.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
        ];
        return lunchRecipes[index % lunchRecipes.length];
      case MealType.dinner:
        final dinnerRecipes = [
          {
            'title': 'Grilled Fish',
            'time': '25',
            'cal': '380 Cal',
            'image': images[0],
            'ingredients': [
              'Fish fillet',
              'Lemon',
              'Herbs',
              'Olive oil',
              'Garlic',
            ],
            'preparation':
                'Season fish with herbs, garlic, and olive oil. Grill or bake until flaky. Serve with lemon wedges.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
          {
            'title': 'Pasta Primavera',
            'time': '18',
            'cal': '350 Cal',
            'image': images[1],
            'ingredients': [
              'Pasta',
              'Mixed vegetables',
              'Garlic',
              'Olive oil',
              'Parmesan',
            ],
            'preparation':
                'Cook pasta. Sauté vegetables with garlic and olive oil. Toss with pasta and parmesan. Serve.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
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
              final timeStr =
                  (recipeData['time'] as String?).toString().contains('Minutes')
                  ? recipeData['time']
                  : '${recipeData['time']} Minutes';
              return GestureDetector(
                onTap: () {
                  GoRouter.of(
                    context,
                  ).push(AppRouter.kRecipeDetailView, extra: recipeData);
                },
                child: CustomWorkoutCardWidget(
                  key: ValueKey('recipe_${mealType}_$index'),
                  title: recipeData['title']!,
                  imagePath: recipeData['image']!,
                  subTitle1: timeStr,
                  subTitle2: recipeData['cal']!,
                  cardWidth: null,
                ),
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
