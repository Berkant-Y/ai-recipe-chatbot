import 'package:flutter/material.dart';

class NutritionInfo {
  final int calories;
  final double protein;    // gram
  final double carbs;      // gram
  final double fat;        // gram
  final double fiber;      // gram
  final double sugar;      // gram
  final double sodium;     // mg
  final double healthScore; // 0-100

  const NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    required this.healthScore,
  });

  factory NutritionInfo.fromJson(Map<String, dynamic> json) {
    return NutritionInfo(
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      carbs: (json['carbs'] as num?)?.toDouble() ?? 0.0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
      fiber: (json['fiber'] as num?)?.toDouble() ?? 0.0,
      sugar: (json['sugar'] as num?)?.toDouble() ?? 0.0,
      sodium: (json['sodium'] as num?)?.toDouble() ?? 0.0,
      healthScore: (json['healthScore'] as num?)?.toDouble() ?? 50.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'healthScore': healthScore,
    };
  }

  // Beslenme kategorisi
  String get category {
    if (healthScore >= 80) return 'Çok Sağlıklı';
    if (healthScore >= 60) return 'Sağlıklı';
    if (healthScore >= 40) return 'Orta';
    return 'Dikkatli Tüketin';
  }

  // Renk kodu
  Color get categoryColor {
    if (healthScore >= 80) return Colors.green;
    if (healthScore >= 60) return Colors.lightGreen;
    if (healthScore >= 40) return Colors.orange;
    return Colors.red;
  }

  @override
  String toString() {
    return 'NutritionInfo(calories: $calories, protein: ${protein}g, healthScore: $healthScore)';
  }
}