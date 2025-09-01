class FineTuningService {
  // Dummy: Fine-tuned modelden tarif önerisi (gerçek projede API ile)
  static List<Map<String, dynamic>> getFineTunedRecipes(List<String> ingredients) {
    // Burada gerçek fine-tuned model API çağrısı yapılabilir
    // Şimdilik örnek veri dönüyoruz
    return [
      {
        'id': 'fine_tuned_1',
        'name': 'Fine Tuned Menemen',
        'ingredients': ['yumurta', 'domates', 'biber', 'soğan'],
        'instructions': [
          'Soğanı ve biberi kavurun.',
          'Domatesi ekleyin, pişirin.',
          'Yumurtaları kırıp karıştırın.',
          'Servis edin.'
        ],
        'cookingTime': 15,
        'difficulty': 'kolay',
        'source': 'fine-tuned-model'
      }
    ];
  }
}