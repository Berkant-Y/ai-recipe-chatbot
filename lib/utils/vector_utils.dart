import 'dart:math';

class VectorUtils {
  // Basit embedding: kelimeleri hashleyip vektör oluşturur
  static List<double> simpleEmbedding(String text, {int dim = 384}) {
    List<double> vector = List.filled(dim, 0.0);
    for (final word in text.toLowerCase().split(' ')) {
      int hash = word.hashCode.abs() % dim;
      vector[hash] += 1.0;
    }
    // Normalize
    double mag = sqrt(vector.map((v) => v * v).reduce((a, b) => a + b));
    if (mag > 0) {
      vector = vector.map((v) => v / mag).toList();
    }
    return vector;
  }

  // Cosine similarity
  static double cosineSimilarity(List<double> a, List<double> b) {
    if (a.length != b.length) return 0.0;
    double dot = 0.0, magA = 0.0, magB = 0.0;
    for (int i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      magA += a[i] * a[i];
      magB += b[i] * b[i];
    }
    if (magA == 0.0 || magB == 0.0) return 0.0;
    return dot / (sqrt(magA) * sqrt(magB));
  }
}