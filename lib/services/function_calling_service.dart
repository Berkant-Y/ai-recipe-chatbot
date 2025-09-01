import '../services/vector_service.dart';

class FunctionCallingService {
  // Fonksiyon: Malzemelere göre benzer tarif öner
  static Map<String, dynamic> searchRecipesByIngredients(List<String> ingredients, {int limit = 3}) {
    final similar = VectorService.findSimilarRecipes(ingredients, limit: limit);
    return {
      'success': true,
      'recipes': similar.map((e) => e['recipe']).toList(),
    };
  }

  // Fonksiyon: Alternatif malzeme öner
  static List<String> suggestAlternatives(String missingIngredient) {
    // Basit örnek veri
    final alternatives = {
      'yumurta': ['tofu', 'peynir', 'nohut unu'],
      'süt': ['badem sütü', 'soya sütü', 'yoğurt'],
      'un': ['mısır unu', 'pirinç unu', 'yulaf unu'],
    };
    return alternatives[missingIngredient.toLowerCase()] ?? [];
  }

  // Fonksiyon: Basit beslenme analizi (dummy)
  static Map<String, dynamic> analyzeNutrition(List<String> ingredients) {
    int calories = 0;
    for (final ing in ingredients) {
      if (ing.toLowerCase().contains('yumurta')) calories += 70;
      if (ing.toLowerCase().contains('domates')) calories += 20;
    }
    return {
      'calories': calories,
      'healthScore': calories < 300 ? 80 : 50,
    };
  }
}