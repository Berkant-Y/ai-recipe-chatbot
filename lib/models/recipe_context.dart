import 'package:flutter/material.dart';
import 'nutrition_info.dart';
import 'cooking_step.dart';

class RecipeContext {
  final String id;
  final List<String> searchIngredients;
  final List<SimilarRecipe> similarRecipes;
  final Map<String, double> ingredientSimilarities;
  final String cuisine;
  final List<String> techniques;
  final String season; // 'kış', 'yaz', 'sonbahar', 'ilkbahar'
  final List<String> dietaryRestrictions; // 'vejetaryen', 'vegan', 'glutensiz'
  final double contextScore; // 0-1 arası, ne kadar uygun
  final DateTime createdAt;

  const RecipeContext({
    required this.id,
    required this.searchIngredients,
    this.similarRecipes = const [],
    this.ingredientSimilarities = const {},
    this.cuisine = 'türk',
    this.techniques = const [],
    this.season = 'genel',
    this.dietaryRestrictions = const [],
    this.contextScore = 0.5,
    required this.createdAt,
  });

  factory RecipeContext.fromJson(Map<String, dynamic> json) {
    return RecipeContext(
      id: json['id'] ?? '',
      searchIngredients: List<String>.from(json['searchIngredients'] ?? []),
      similarRecipes: (json['similarRecipes'] as List? ?? [])
          .map((item) => SimilarRecipe.fromJson(item))
          .toList(),
      ingredientSimilarities: Map<String, double>.from(json['ingredientSimilarities'] ?? {}),
      cuisine: json['cuisine'] ?? 'türk',
      techniques: List<String>.from(json['techniques'] ?? []),
      season: json['season'] ?? 'genel',
      dietaryRestrictions: List<String>.from(json['dietaryRestrictions'] ?? []),
      contextScore: (json['contextScore'] as num?)?.toDouble() ?? 0.5,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'searchIngredients': searchIngredients,
      'similarRecipes': similarRecipes.map((r) => r.toJson()).toList(),
      'ingredientSimilarities': ingredientSimilarities,
      'cuisine': cuisine,
      'techniques': techniques,
      'season': season,
      'dietaryRestrictions': dietaryRestrictions,
      'contextScore': contextScore,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Context kalitesi
  String get contextQuality {
    if (contextScore >= 0.8) return 'Mükemmel Uyum';
    if (contextScore >= 0.6) return 'İyi Uyum';
    if (contextScore >= 0.4) return 'Orta Uyum';
    return 'Zayıf Uyum';
  }

  // Context rengi
  Color get contextColor {
    if (contextScore >= 0.8) return Colors.green;
    if (contextScore >= 0.6) return Colors.lightGreen;
    if (contextScore >= 0.4) return Colors.orange;
    return Colors.red;
  }

  // En uygun benzer tarif
  SimilarRecipe? get bestSimilarRecipe {
    if (similarRecipes.isEmpty) return null;
    return similarRecipes.reduce((a, b) => a.similarity > b.similarity ? a : b);
  }

  // Mevsim uyumluluğu
  bool get isSeasonAppropriate {
    if (season == 'genel') return true;
    String currentSeason = _getCurrentSeason();
    return season == currentSeason;
  }

  String _getCurrentSeason() {
    int month = DateTime.now().month;
    if (month >= 3 && month <= 5) return 'ilkbahar';
    if (month >= 6 && month <= 8) return 'yaz';
    if (month >= 9 && month <= 11) return 'sonbahar';
    return 'kış';
  }

  @override
  String toString() {
    return 'RecipeContext(${searchIngredients.length} ingredients, score: $contextScore)';
  }
}

// Benzer Tarif Modeli
class SimilarRecipe {
  final String id;
  final String name;
  final List<String> ingredients;
  final double similarity; // 0-1 arası
  final String technique;
  final String difficulty;
  final int cookingTime;

  const SimilarRecipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.similarity,
    this.technique = 'genel',
    this.difficulty = 'kolay',
    this.cookingTime = 30,
  });

  factory SimilarRecipe.fromJson(Map<String, dynamic> json) {
    return SimilarRecipe(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      similarity: (json['similarity'] as num?)?.toDouble() ?? 0.0,
      technique: json['technique'] ?? 'genel',
      difficulty: json['difficulty'] ?? 'kolay',
      cookingTime: (json['cookingTime'] as num?)?.toInt() ?? 30,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'similarity': similarity,
      'technique': technique,
      'difficulty': difficulty,
      'cookingTime': cookingTime,
    };
  }

  // Benzerlik yüzdesi
  String get similarityPercentage => '${(similarity * 100).toStringAsFixed(1)}%';

  // Benzerlik rengi
  Color get similarityColor {
    if (similarity >= 0.8) return Colors.green;
    if (similarity >= 0.6) return Colors.lightGreen;
    if (similarity >= 0.4) return Colors.orange;
    return Colors.red;
  }

  @override
  String toString() {
    return 'SimilarRecipe($name, ${similarityPercentage})';
  }
}

// Context Builder Helper
class RecipeContextBuilder {
  String? _id;
  List<String> _searchIngredients = [];
  List<SimilarRecipe> _similarRecipes = [];
  Map<String, double> _ingredientSimilarities = {};
  String _cuisine = 'türk';
  List<String> _techniques = [];
  String _season = 'genel';
  List<String> _dietaryRestrictions = [];
  double _contextScore = 0.5;

  RecipeContextBuilder setId(String id) {
    _id = id;
    return this;
  }

  RecipeContextBuilder setSearchIngredients(List<String> ingredients) {
    _searchIngredients = ingredients;
    return this;
  }

  RecipeContextBuilder addSimilarRecipe(SimilarRecipe recipe) {
    _similarRecipes.add(recipe);
    return this;
  }

  RecipeContextBuilder setCuisine(String cuisine) {
    _cuisine = cuisine;
    return this;
  }

  RecipeContextBuilder setSeason(String season) {
    _season = season;
    return this;
  }

  RecipeContextBuilder setContextScore(double score) {
    _contextScore = score;
    return this;
  }

  RecipeContextBuilder addDietaryRestriction(String restriction) {
    _dietaryRestrictions.add(restriction);
    return this;
  }

  RecipeContext build() {
    return RecipeContext(
      id: _id ?? 'ctx_${DateTime.now().millisecondsSinceEpoch}',
      searchIngredients: _searchIngredients,
      similarRecipes: _similarRecipes,
      ingredientSimilarities: _ingredientSimilarities,
      cuisine: _cuisine,
      techniques: _techniques,
      season: _season,
      dietaryRestrictions: _dietaryRestrictions,
      contextScore: _contextScore,
      createdAt: DateTime.now(),
    );
  }
}