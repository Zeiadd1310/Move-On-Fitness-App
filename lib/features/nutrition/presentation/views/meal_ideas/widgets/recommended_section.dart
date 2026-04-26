import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/features/home/presentation/views/widgets/custom_workout_card_widget.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';

class RecommendedSection extends StatelessWidget {
  final MealType mealType;
  final List<Map<String, dynamic>> recipes;

  const RecommendedSection({
    super.key,
    this.mealType = MealType.breakfast,
    this.recipes = const [],
  });

  @override
  Widget build(BuildContext context) {
    final cards = recipes.length > 1
        ? recipes.skip(1).take(2).toList()
        : recipes.take(2).toList();
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
              final recipeData = cards[index];
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
            itemCount: cards.length,
          ),
        ),
      ],
    );
  }
}
