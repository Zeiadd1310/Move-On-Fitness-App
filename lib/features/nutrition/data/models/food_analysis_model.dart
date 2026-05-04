class FoodAnalysisModel {
  const FoodAnalysisModel({
    required this.foodName,
    required this.foodNameEn,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    required this.servingSize,
    required this.mealType,
    required this.healthyScore,
    required this.ingredients,
    required this.healthLevel,
  });

  final String foodName;
  final String foodNameEn;
  final int calories;
  final num protein;
  final num carbs;
  final num fat;
  final num fiber;
  final num sugar;
  final num sodium;
  final num servingSize;
  final String mealType;
  final int healthyScore;
  final List<String> ingredients;
  final String healthLevel;

  factory FoodAnalysisModel.fromJson(Map<String, dynamic> json) {
    num readNum(String key) {
      final raw = json[key];
      if (raw is num) return raw;
      return num.tryParse(raw?.toString() ?? '') ?? 0;
    }

    int readInt(String key) {
      final raw = json[key];
      if (raw is int) return raw;
      if (raw is num) return raw.toInt();
      return int.tryParse(raw?.toString() ?? '') ?? 0;
    }

    final ingredientsRaw = json['ingredients'];
    final ingredients = (ingredientsRaw is List)
        ? ingredientsRaw.map((e) => e.toString()).toList()
        : const <String>[];

    return FoodAnalysisModel(
      foodName: (json['food_name'] ?? '').toString(),
      foodNameEn: (json['food_name_en'] ?? '').toString(),
      calories: readInt('calories'),
      protein: readNum('protein'),
      carbs: readNum('carbs'),
      fat: readNum('fat'),
      fiber: readNum('fiber'),
      sugar: readNum('sugar'),
      sodium: readNum('sodium'),
      servingSize: readNum('serving_size'),
      mealType: (json['meal_type'] ?? '').toString(),
      healthyScore: readInt('healthy_score'),
      ingredients: ingredients,
      healthLevel: (json['health_level'] ?? '').toString(),
    );
  }
}

