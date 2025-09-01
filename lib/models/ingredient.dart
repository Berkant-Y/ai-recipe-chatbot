class Ingredient {
  final String id;
  final String name;
  final String category;
  final String? unit;

  Ingredient({
    required this.id,
    required this.name,
    required this.category,
    this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'unit': unit,
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      unit: json['unit'],
    );
  }
}