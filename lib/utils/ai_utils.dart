class AIUtils {
  // Prompt temizleme: kod bloklarını ve gereksiz karakterleri kaldırır
  static String cleanPrompt(String text) {
    // Kod bloklarını kaldır
    if (text.contains('```')) {
      int start = text.indexOf('{');
      int end = text.lastIndexOf('}') + 1;
      if (start != -1 && end > start) {
        return text.substring(start, end);
      }
    }
    // JSON dışındaki açıklamaları kaldır
    int jsonStart = text.indexOf('{');
    if (jsonStart != -1) {
      int jsonEnd = text.lastIndexOf('}');
      if (jsonEnd != -1) {
        return text.substring(jsonStart, jsonEnd + 1);
      }
    }
    return text.trim();
  }

  // Türkçe zorluk seviyesini İngilizce'ye çevir
  static String difficultyToEnglish(String diff) {
    switch (diff.toLowerCase()) {
      case 'kolay':
        return 'easy';
      case 'orta':
        return 'medium';
      case 'zor':
        return 'hard';
      default:
        return diff;
    }
  }

  // Malzeme listesini tek satır stringe çevir
  static String ingredientsToLine(List<String> ingredients) {
    return ingredients.map((e) => e.trim()).join(', ');
  }
}