import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class RecipeListCard extends StatelessWidget {
  final MealType mealType;
  final int index;

  const RecipeListCard({
    super.key,
    this.mealType = MealType.breakfast,
    this.index = 0,
  });

  Map<String, dynamic> _getRecipeData() {
    final images = [
      'assets/images/for you 1.png',
      'assets/images/for you 2.png',
      'assets/images/recommended 1.png',
      'assets/images/recommended 2.png',
    ];

    switch (mealType) {
      case MealType.breakfast:
        final breakfastRecipes = [
          {
            'title': 'Delights With Greek Yogurt',
            'time': '6',
            'cal': '200',
            'image': images[0],
            'ingredients': [
              'Greek yogurt',
              'Honey',
              'Mixed berries',
              'Granola',
              'Mint',
            ],
            'preparation':
                'Spoon yogurt into a bowl. Top with berries, granola, and drizzle with honey. Garnish with mint.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
          {
            'title': 'Avocado Toast',
            'time': '5',
            'cal': '250',
            'image': images[1],
            'ingredients': [
              'Bread',
              'Ripe avocado',
              'Lemon juice',
              'Salt and pepper',
              'Red pepper flakes',
            ],
            'preparation':
                'Toast the bread. Mash avocado with lemon, salt and pepper. Spread on toast and top with red pepper flakes.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
        ];
        return breakfastRecipes[index % breakfastRecipes.length];
      case MealType.lunch:
        final lunchRecipes = [
          {
            'title': 'Caesar Salad Bowl',
            'time': '12',
            'cal': '280',
            'image': images[0],
            'ingredients': [
              'Romaine lettuce',
              'Caesar dressing',
              'Parmesan',
              'Croutons',
              'Lemon',
            ],
            'preparation':
                'Chop romaine and add to a bowl. Toss with Caesar dressing, parmesan, and croutons. Finish with lemon.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
          {
            'title': 'Turkey Sandwich',
            'time': '10',
            'cal': '320',
            'image': images[1],
            'ingredients': [
              'Turkey slices',
              'Bread',
              'Lettuce',
              'Tomato',
              'Mayo or mustard',
            ],
            'preparation':
                'Layer turkey, lettuce, and tomato on bread. Add mayo or mustard. Serve with a side of choice.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
        ];
        return lunchRecipes[index % lunchRecipes.length];
      case MealType.dinner:
        final dinnerRecipes = [
          {
            'title': 'Beef Steak & Veggies',
            'time': '30',
            'cal': '450',
            'image': images[0],
            'ingredients': [
              'Beef steak',
              'Broccoli',
              'Carrots',
              'Garlic',
              'Olive oil',
              'Herbs',
            ],
            'preparation':
                'Season and grill or pan-sear the steak. Roast vegetables with olive oil and garlic. Rest steak, slice, and serve with veggies.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
          {
            'title': 'Vegetable Stir Fry',
            'time': '15',
            'cal': '280',
            'image': images[1],
            'ingredients': [
              'Mixed vegetables',
              'Soy sauce',
              'Garlic',
              'Ginger',
              'Sesame oil',
            ],
            'preparation':
                'Heat oil in a wok. Add garlic and ginger, then vegetables. Stir-fry until tender. Add soy sauce and toss. Serve over rice if desired.',
            'mealType': mealType,
            'isRecipeOfTheDay': false,
          },
        ];
        return dinnerRecipes[index % dinnerRecipes.length];
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipeData = _getRecipeData();

    // #region agent log
    _log('recipe_list_card.dart:25', 'RecipeListCard build started', {
      'widgetType': 'RecipeListCard',
      'mealType': mealType.toString(),
    }, 'A');
    // #endregion
    return Align(
      alignment: AlignmentGeometry.center,
      child: Container(
        height: 110,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      recipeData['title']!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          size: 14,
                          color: Color(0xff212020),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${recipeData['time']} Minutes',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff212020),
                            fontFamily: 'League Spartan',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          FontAwesomeIcons.fire,
                          size: 14,
                          color: Color(0xff212020),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${recipeData['cal']} Cal',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff212020),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(20),
              ),
              child: Image.asset(
                recipeData['image']!,
                width: 150,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // #region agent log
                  _log('recipe_list_card.dart:154', 'Image.asset error', {
                    'error': error.toString(),
                    'asset': recipeData['image'],
                  }, 'B');
                  // #endregion
                  return Container(
                    color: Colors.grey,
                    width: 150,
                    height: double.infinity,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
