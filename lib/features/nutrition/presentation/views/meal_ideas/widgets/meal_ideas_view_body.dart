import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/features/nutrition/presentation/cubits/generate_nutrition_plan_cubit/generate_nutrition_plan_cubit.dart';
import 'package:move_on/core/utils/nutrition_recipe_mapper.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_ideas_header.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipe_of_the_day_card.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipes_for_you_section.dart';
import 'package:move_on/features/nutrition/data/models/food_analysis_model.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/meals_model.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/snacks_section.dart';
import 'package:move_on/features/nutrition/presentation/cubits/food_scan_cubit/food_scan_cubit.dart';

class MealIdeasViewBody extends StatefulWidget {
  const MealIdeasViewBody({super.key});

  @override
  State<MealIdeasViewBody> createState() => _MealIdeasViewBodyState();
}

class _MealIdeasViewBodyState extends State<MealIdeasViewBody> {
  MealType _currentMealType = MealType.breakfast;
  bool _foodScanLoadingShown = false;

  void _onMealTypeChanged(MealType mealType) {
    setState(() {
      _currentMealType = mealType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final spacing = responsive.spacing(16);

    return MultiBlocListener(
      listeners: [
        BlocListener<FoodScanCubit, FoodScanState>(
          listener: (context, state) {
            if (state is FoodScanLoading) {
              _showFoodScanLoading(context);
              return;
            }

            _hideFoodScanLoadingIfNeeded(context);

            if (state is FoodScanFailure) {
              CustomErrorSnackBar.show(context, state.error);
            } else if (state is FoodScanSuccess) {
              _showFoodResultSheet(
                context,
                analysis: state.analysis,
                imagePath: state.imagePath,
              );
            }
          },
        ),
      ],
      child: Scaffold(
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
                                    .loadOrGenerateNutritionPlan(
                                      forceRefresh: true,
                                    );
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    final successState = state as GenerateNutritionPlanSuccess;
                    final week = successState.mealsModel.weekPlan ?? const [];
                    final firstDay = week.isNotEmpty ? week.first : null;
                    final otherDay = week.length > 1 ? week[1] : firstDay;

                    if (firstDay == null) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Center(
                          child: Text(
                            'No meals available yet.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }

                    final recipeOfDayRecipes =
                        NutritionRecipeMapper.forMealType(
                          MealsModel(
                            dailyCalories:
                                successState.mealsModel.dailyCalories,
                            protein: successState.mealsModel.protein,
                            weekPlan: [firstDay],
                          ),
                          _currentMealType,
                        );

                    final forYouRecipes = NutritionRecipeMapper.forMealType(
                      MealsModel(
                        dailyCalories: successState.mealsModel.dailyCalories,
                        protein: successState.mealsModel.protein,
                        weekPlan: otherDay == null ? [firstDay] : [otherDay],
                      ),
                      _currentMealType,
                    );

                    return Column(
                      children: [
                        RecipeOfTheDayCard(
                          mealType: _currentMealType,
                          recipes: recipeOfDayRecipes,
                        ),
                        SizedBox(height: spacing),
                        // Snacks section instead of Recommended
                        SnacksSection(snacks: firstDay.snacks),
                        SizedBox(height: spacing),
                        RecipesForYouSection(
                          mealType: _currentMealType,
                          recipes: forYouRecipes,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFoodScanLoading(BuildContext context) {
    if (_foodScanLoadingShown) return;
    _foodScanLoadingShown = true;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _FoodScanLoadingDialog(),
    );
  }

  void _hideFoodScanLoadingIfNeeded(BuildContext context) {
    if (!_foodScanLoadingShown) return;
    _foodScanLoadingShown = false;

    // Close the top-most route if it's our loading dialog.
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  void _showFoodResultSheet(
    BuildContext context, {
    required FoodAnalysisModel analysis,
    required String imagePath,
  }) {
    final displayName = analysis.foodNameEn.trim().isNotEmpty
        ? analysis.foodNameEn.trim()
        : analysis.foodName.trim();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        final h = MediaQuery.of(context).size.height;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              height: (h * 0.28).clamp(150.0, 190.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(
                      File(imagePath),
                      width: 150,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 150,
                        height: double.infinity,
                        color: const Color(0xFFF3F4F6),
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName.isEmpty ? 'Food' : displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${analysis.calories} kcal',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 18,
                          runSpacing: 8,
                          children: [
                            _macro('carbs', analysis.carbs),
                            _macro('protein', analysis.protein),
                            _macro('fats', analysis.fat),
                            _macro('sugar', analysis.sugar),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _macro(String label, num value) {
    final v = value is int ? value.toString() : value.toStringAsFixed(1);
    return Text(
      '$v g $label',
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

class _FoodScanLoadingDialog extends StatelessWidget {
  const _FoodScanLoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            SizedBox(width: 12),
            Flexible(
              child: Text(
                'Analyzing food…',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
