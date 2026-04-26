import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipe_list_card.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';

class RecipesForYouSection extends StatelessWidget {
  final MealType mealType;
  final List<Map<String, dynamic>> recipes;

  const RecipesForYouSection({
    super.key,
    this.mealType = MealType.breakfast,
    this.recipes = const [],
  });

  @override
  Widget build(BuildContext context) {
    final cards = recipes.take(2).toList();
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
          for (int i = 0; i < cards.length; i++) ...[
            RecipeListCard(recipeData: cards[i]),
            if (i < cards.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
