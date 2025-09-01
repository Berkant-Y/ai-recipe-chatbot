class Recipe {
  final String id;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;
  final String difficulty;
  final int cookingTime;
  final String? imageUrl;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.difficulty,
    required this.cookingTime,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'difficulty': difficulty,
      'cookingTime': cookingTime,
      'imageUrl': imageUrl,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      ingredients: json['ingredients'].cast<String>(),
      instructions: json['instructions'].cast<String>(),
      difficulty: json['difficulty'],
      cookingTime: json['cookingTime'],
      imageUrl: json['imageUrl'],
    );
  }
}