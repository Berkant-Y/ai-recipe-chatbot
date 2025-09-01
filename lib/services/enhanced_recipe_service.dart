import '../services/vector_service.dart';
import '../services/function_calling_service.dart';

class EnhancedRecipeService {
  // RAG + Function Calling ile gelişmiş tarif önerisi
  static List<Map<String, dynamic>> getEnhancedRecipeSuggestions(List<String> ingredients) {
    // 1. RAG context oluştur
    String ragContext = VectorService.generateRAGContext(ingredients);

    // 2. Benzer tarifleri bul
    final similar = VectorService.findSimilarRecipes(ingredients, limit: 5);

    // 3. Fonksiyonel analiz (ör: beslenme)
    final nutrition = FunctionCallingService.analyzeNutrition(ingredients);

    // 4. Sonuçları birleştir
    return [
      {
        'context': ragContext,
        'similarRecipes': similar.map((e) => e['recipe']).toList(),
        'nutrition': nutrition,
      }
    ];
  }
}