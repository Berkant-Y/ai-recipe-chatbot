import 'dart:io';

class MultimodalService {
  // Dummy: Görselden malzeme tahmini (gerçek projede ML/AI ile)
  static Future<List<String>> predictIngredientsFromImage(File imageFile) async {
    // Burada gerçek bir görsel işleme modeli kullanılabilir
    // Şimdilik örnek veri dönüyoruz
    await Future.delayed(Duration(seconds: 1));
    return ['domates', 'biber', 'yumurta'];
  }

  // Dummy: Görselden yemek adı tahmini
  static Future<String> predictDishNameFromImage(File imageFile) async {
    await Future.delayed(Duration(milliseconds: 800));
    return 'Menemen';
  }
}