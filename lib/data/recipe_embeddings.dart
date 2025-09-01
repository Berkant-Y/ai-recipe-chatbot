class RecipeEmbeddings {
  // Her tarif için örnek (dummy) embedding vektörleri (384 boyutlu)
  static final Map<String, List<double>> embeddings = {
    'patlican_musakka': List.filled(384, 0.01)..[0] = 0.9,
    'imam_bayildi': List.filled(384, 0.01)..[1] = 0.9,
    'menemen': List.filled(384, 0.01)..[2] = 0.9,
    'mercimek_corbasi': List.filled(384, 0.01)..[3] = 0.9,
    'dolma': List.filled(384, 0.01)..[4] = 0.9,
  };

  // Embedding boyutu
  static int get dimension => 384;
}