import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/responsive_helper.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_ideas_header.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipe_of_the_day_card.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipes_for_you_section.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recommended_section.dart';

class MealIdeasViewBody extends StatefulWidget {
  const MealIdeasViewBody({super.key});

  @override
  State<MealIdeasViewBody> createState() => _MealIdeasViewBodyState();
}

class _MealIdeasViewBodyState extends State<MealIdeasViewBody> {
  MealType _currentMealType = MealType.breakfast;

  void _onMealTypeChanged(MealType mealType) {
    setState(() {
      _currentMealType = mealType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final spacing = responsive.spacing(16);
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MealIdeasHeader(),
              MealTabs(onTabChanged: _onMealTypeChanged),
              SizedBox(height: spacing),
              RecipeOfTheDayCard(mealType: _currentMealType),
              SizedBox(height: spacing),
              RecommendedSection(mealType: _currentMealType),
              SizedBox(height: spacing),
              RecipesForYouSection(mealType: _currentMealType),
            ],
          ),
        ),
      ),
    );
  }
}
