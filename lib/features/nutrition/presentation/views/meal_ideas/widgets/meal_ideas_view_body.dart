import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/features/nutrition/presentation/cubits/generate_nutrition_plan_cubit/generate_nutrition_plan_cubit.dart';
import 'package:move_on/core/utils/nutrition_recipe_mapper.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_ideas_header.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipe_of_the_day_card.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipes_for_you_section.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/meals_model.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/snacks_section.dart';

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
              BlocBuilder<
                GenerateNutritionPlanCubit,
                GenerateNutritionPlanState
              >(
                builder: (context, state) {
                  if (state is GenerateNutritionPlanLoading ||
                      state is GenerateNutritionPlanInitial) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is GenerateNutritionPlanFailure) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Column(
                        children: [
                          Text(
                            state.errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<GenerateNutritionPlanCubit>()
                                  .generateNutritionPlan();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final successState = state as GenerateNutritionPlanSuccess;
                  // Only use the first day of the week plan
                  final firstDay =
                      (successState.mealsModel.weekPlan != null &&
                          successState.mealsModel.weekPlan!.isNotEmpty)
                      ? successState.mealsModel.weekPlan!.first
                      : null;

                  if (firstDay == null) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Center(
                        child: Text(
                          'No meals available yet.',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    );
                  }

                  final recipes = NutritionRecipeMapper.forMealType(
                    MealsModel(
                      dailyCalories: successState.mealsModel.dailyCalories,
                      protein: successState.mealsModel.protein,
                      weekPlan: [firstDay],
                    ),
                    _currentMealType,
                  );

                  return Column(
                    children: [
                      RecipeOfTheDayCard(
                        mealType: _currentMealType,
                        recipes: recipes,
                      ),
                      SizedBox(height: spacing),
                      // Snacks section instead of Recommended
                      SnacksSection(snacks: firstDay.snacks),
                      SizedBox(height: spacing),
                      RecipesForYouSection(
                        mealType: _currentMealType,
                        recipes: recipes,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
