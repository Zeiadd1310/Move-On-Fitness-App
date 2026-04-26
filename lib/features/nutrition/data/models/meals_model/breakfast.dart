import 'package:equatable/equatable.dart';

class Breakfast extends Equatable {
  final List<String>? meal;
  final String? description;
  final String? quantity;
  final int? calories;
  final int? protein;
  final String? steps;
  final String? image;

  const Breakfast({
    this.meal,
    this.description,
    this.quantity,
    this.calories,
    this.protein,
    this.steps,
    this.image,
  });

  static int? _asInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static List<String>? _asMealList(dynamic value) {
    if (value == null) return null;
    if (value is List) return value.map((e) => e.toString()).toList();
    if (value is String) return [value]; // API returned a plain String
    return null;
  }

  factory Breakfast.fromJson(Map<String, dynamic> json) => Breakfast(
    // meal: (json['meal'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    meal: _asMealList(json['meal']),
    description: json['description'] as String?,
    quantity: json['quantity'] as String?,
    calories: _asInt(json['calories']),
    protein: _asInt(json['protein']),
    steps: json['steps'] as String?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'meal': meal,
    'description': description,
    'quantity': quantity,
    'calories': calories,
    'protein': protein,
    'steps': steps,
    'image': image,
  };

  @override
  List<Object?> get props {
    return [meal, description, quantity, calories, protein, steps, image];
  }
}
