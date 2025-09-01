class TextProcessing {
  // Cümleleri noktalama işaretlerine göre ayırır
  static List<String> splitSentences(String text) {
    return text
        .split(RegExp(r'[.!?]'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  // İlk harfi büyük yapar
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // Türkçe karakterleri İngilizce'ye çevirir
  static String turkishToEnglish(String text) {
    return text
        .replaceAll('ç', 'c')
        .replaceAll('ğ', 'g')
        .replaceAll('ı', 'i')
        .replaceAll('ö', 'o')
        .replaceAll('ş', 's')
        .replaceAll('ü', 'u')
        .replaceAll('Ç', 'C')
        .replaceAll('Ğ', 'G')
        .replaceAll('İ', 'I')
        .replaceAll('Ö', 'O')
        .replaceAll('Ş', 'S')
        .replaceAll('Ü', 'U');
  }

  // Metni kısa özetle (ilk 100 karakter)
  static String summarize(String text, {int maxLength = 100}) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
  }
}