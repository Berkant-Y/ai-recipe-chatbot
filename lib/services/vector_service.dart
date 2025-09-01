import '../data/recipe_embeddings.dart';
import '../data/turkish_cuisine_knowledge.dart';
import '../utils/vector_utils.dart';

class VectorService {
  // Tarif embedding'lerini belleğe al
  // Her tarifin vektör temsili (embedding) ve tarif verisi burada tutulur.
  static final Map<String, List<double>> _embeddings = RecipeEmbeddings.embeddings;
  static final List<Map<String, dynamic>> _recipes = TurkishCuisineKnowledge.recipes;

  // Benzer tarifleri bul (cosine similarity ile)
  static List<Map<String, dynamic>> findSimilarRecipes(List<String> ingredients, {int limit = 3}) {
    String query = ingredients.join(' ');
    List<double> queryEmbedding = VectorUtils.simpleEmbedding(query);

    List<Map<String, dynamic>> similarities = [];

    for (String key in _embeddings.keys) {
      double similarity = VectorUtils.cosineSimilarity(queryEmbedding, _embeddings[key]!);
      Map<String, dynamic> recipe = _recipes.firstWhere(
        (r) => r['id'] == key,
        orElse: () => {},
      );
      if (recipe.isNotEmpty) {
        similarities.add({
          'key': key,
          'recipe': recipe,
          'similarity': similarity,
        });
      }
    }

    similarities.sort((a, b) => b['similarity'].compareTo(a['similarity']));
    return similarities.take(limit).toList();
  }

  // RAG context üretir, LLM'ye bilgi sağlar.
  // Bu sayede model, Benzer tarifleri öneri üretirken bu bilgileri kullanabilir.
  static String generateRAGContext(List<String> ingredients) {
    List<Map<String, dynamic>> similarRecipes = findSimilarRecipes(ingredients);

    if (similarRecipes.isEmpty) return '';

    StringBuffer context = StringBuffer();
    context.writeln('Benzer Tarifler:');
    for (var item in similarRecipes) {
      Map<String, dynamic> recipe = item['recipe'];
      double similarity = item['similarity'];
      context.writeln(
        '${recipe['name']} (Benzerlik: ${(similarity * 100).toStringAsFixed(1)}%)\n'
        'Malzemeler: ${recipe['ingredients'].join(', ')}\n'
        'Teknik: ${recipe['technique']}\n'
        'Açıklama: ${recipe['description']}\n---'
      );
    }
    return context.toString();
  }
}