import 'package:move_on/features/nutrition/data/models/meals_model/breakfast.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/dinner.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/lunch.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/meals_model.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';

class NutritionRecipeMapper {
  static const String _fallbackImage = 'assets/images/nutiration meal.png';

  static List<Map<String, dynamic>> forMealType(
    MealsModel model,
    MealType mealType,
  ) {
    final recipes = <Map<String, dynamic>>[];

    for (final day in model.weekPlan ?? const []) {
      switch (mealType) {
        case MealType.breakfast:
          if (day.breakfast != null) {
            recipes.add(_fromBreakfast(day.breakfast!, mealType));
          }
          break;
        case MealType.lunch:
          if (day.lunch != null) {
            recipes.add(_fromLunch(day.lunch!, mealType));
          }
          break;
        case MealType.dinner:
          if (day.dinner != null) {
            recipes.add(_fromDinner(day.dinner!, mealType));
          }
          break;
      }
    }

    return recipes;
  }

  static Map<String, dynamic> _fromBreakfast(
    Breakfast meal,
    MealType mealType,
  ) {
    final title = _titleFromMeal(meal.meal, mealType);
    final time = _timeFromSteps(meal.steps);
    return {
      'title': title,
      'time': time,
      'calories': '${meal.calories ?? 0} Cal',
      'cal': '${meal.calories ?? 0} Cal',
      'image': meal.image ?? _fallbackImage,
      'ingredients': meal.meal ?? const <String>[],
      'preparation':
          meal.steps ?? meal.description ?? 'No preparation steps available.',
      'mealType': mealType,
      'isRecipeOfTheDay': false,
    };
  }

  static Map<String, dynamic> _fromLunch(Lunch meal, MealType mealType) {
    final title = _titleFromMeal(meal.meal, mealType);
    final time = _timeFromSteps(meal.steps);
    return {
      'title': title,
      'time': time,
      'calories': '${meal.calories ?? 0} Cal',
      'cal': '${meal.calories ?? 0} Cal',
      'image': meal.image ?? _fallbackImage,
      'ingredients': meal.meal ?? const <String>[],
      'preparation':
          meal.steps ?? meal.description ?? 'No preparation steps available.',
      'mealType': mealType,
      'isRecipeOfTheDay': false,
    };
  }

  static Map<String, dynamic> _fromDinner(Dinner meal, MealType mealType) {
    final title = _titleFromMeal(meal.meal, mealType);
    final time = _timeFromSteps(meal.steps);
    return {
      'title': title,
      'time': time,
      'calories': '${meal.calories ?? 0} Cal',
      'cal': '${meal.calories ?? 0} Cal',
      'image': meal.image ?? _fallbackImage,
      'ingredients': meal.meal ?? const <String>[],
      'preparation':
          meal.steps ?? meal.description ?? 'No preparation steps available.',
      'mealType': mealType,
      'isRecipeOfTheDay': false,
    };
  }

  static String _titleFromMeal(List<String>? mealItems, MealType type) {
    if (mealItems == null || mealItems.isEmpty) {
      return _mealTypeTitle(type);
    }
    return mealItems.first;
  }

  static String _mealTypeTitle(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return 'Breakfast Meal';
      case MealType.lunch:
        return 'Lunch Meal';
      case MealType.dinner:
        return 'Dinner Meal';
    }
  }

  static String _timeFromSteps(String? steps) {
    if (steps == null || steps.trim().isEmpty) return '10';
    final text = steps.toLowerCase();
    if (text.contains('bake') || text.contains('grill')) return '25';
    if (text.contains('boil') || text.contains('cook')) return '15';
    return '10';
  }
}
