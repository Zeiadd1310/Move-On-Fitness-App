import 'package:flutter/material.dart';
import 'package:move_on/features/nutrition/presentation/views/nutrition%20get%20started/widgets/nutrition_get_started_view_body.dart';

class NutritionGetStartedView extends StatelessWidget {
  /// When non-null (embedded in [MealIdeasView]), "Know Your Plan" stays on the same
  /// route and only flips the parent to the meal list instead of stacking another screen.
  final VoidCallback? onKnowYourPlan;

  const NutritionGetStartedView({super.key, this.onKnowYourPlan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NutritionGetStartedViewBody(onKnowYourPlan: onKnowYourPlan),
    );
  }
}
