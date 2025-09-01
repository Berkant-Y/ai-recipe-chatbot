import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import '../models/recipe.dart';

class RecipeService {
  static GenerativeModel? _model;
  static Map<String, Recipe> _recipeCache = {}; // Tarif önbelleği

  static GenerativeModel get model {
    if (_model == null) {
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('GEMINI_API_KEY bulunamadı! .env dosyasını kontrol edin.');
      }
      
      _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );
    }
    return _model!;
  }

  // Malzemelerle tarif arama
  static Future<List<Recipe>> searchRecipesByIngredients(List<String> ingredients) async {
    try {
      String geminiResponse = await _generateRecipeSuggestions(ingredients);
      List<Recipe> recipes = parseGeminiResponse(geminiResponse, ingredients);
      for (Recipe recipe in recipes) {
        _recipeCache[recipe.id] = recipe;
      }
      return recipes;
    } catch (e) {
      return _createFallbackRecipes(ingredients);
    }
  }

  // ID ile tarif getir 
  static Future<Recipe?> getRecipeById(String recipeId) async {
    try {
      // Önce cache'den kontrol et
      if (_recipeCache.containsKey(recipeId)) {
        return _recipeCache[recipeId];
      }
      // Cache'de yoksa yeni tarif oluştur
      String recipeName = 'Bilinmeyen Tarif';
      if (recipeId.contains('_')) {
        List<String> parts = recipeId.split('_');
        if (parts.length > 1) {
          recipeName = parts.sublist(1).join(' ').replaceAll('-', ' ');
          if (recipeName.isNotEmpty) {
            recipeName = recipeName[0].toUpperCase() + recipeName.substring(1);
          }
        }
      }
      Recipe newRecipe = _createSingleFallbackRecipe(recipeId, recipeName);
      _recipeCache[recipeId] = newRecipe;
      return newRecipe;
    } catch (e) {
      Recipe errorRecipe = _createSingleFallbackRecipe(recipeId, 'Hata Tarifi');
      _recipeCache[recipeId] = errorRecipe;
      return errorRecipe;
    }
  }

  // Tarif adı ile arama 
  static Future<Recipe?> getRecipeByName(String recipeName, List<String> ingredients) async {
    try {
      // Cache'den ada göre ara
      for (Recipe recipe in _recipeCache.values) {
        if (recipe.name.toLowerCase() == recipeName.toLowerCase()) {
          return recipe;
        }
      }
      // Cache'de bulunamazsa detaylı tarif oluştur
      Recipe detailedRecipe = await _generateDetailedRecipe(recipeName, ingredients);
      _recipeCache[detailedRecipe.id] = detailedRecipe;
      return detailedRecipe;
    } catch (e) {
      return _createSingleFallbackRecipe('detailed_${DateTime.now().millisecondsSinceEpoch}', recipeName);
    }
  }

  // Detaylı tarif oluştur
  static Future<Recipe> _generateDetailedRecipe(String recipeName, List<String> ingredients) async {
    final prompt = '''
"$recipeName" tarifi için detaylı bir yemek tarifi oluştur.
Malzemeler: ${ingredients.join(", ")}

Yanıtını sadece şu JSON formatında ver:

{
  "id": "detailed_recipe_id",
  "name": "$recipeName",
  "ingredients": ["malzeme1 - 2 adet", "malzeme2 - 1 çay bardağı", "malzeme3 - 1 çorba kaşığı"],
  "instructions": [
    "Adım 1: Detaylı açıklama...",
    "Adım 2: Detaylı açıklama...",
    "Adım 3: Detaylı açıklama..."
  ],
  "cookingTime": 30,
  "difficulty": "Kolay"
}

ÖNEMLİ KURALLAR:
- Malzemelerde miktarları belirt (2 adet, 1 su bardağı, vb.)
- En az 5-8 detaylı adım yaz
- Her adımı açık ve anlaşılır şekilde açıkla
- Pişirme süresi gerçekçi olsun
- JSON formatının dışında hiçbir açıklama yazma
    ''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      String responseText = response.text ?? '';
      
      if (responseText.isNotEmpty) {
        Map<String, dynamic> jsonData = _parseJsonResponse(responseText);
        
        return Recipe(
          id: 'detailed_${DateTime.now().millisecondsSinceEpoch}',
          name: jsonData['name'] ?? recipeName,
          ingredients: List<String>.from(jsonData['ingredients'] ?? ingredients),
          instructions: List<String>.from(jsonData['instructions'] ?? ['Tarif detayları hazırlanıyor...']),
          cookingTime: (jsonData['cookingTime'] as num?)?.toInt() ?? 30,
          difficulty: jsonData['difficulty'] ?? 'Kolay',
          imageUrl: 'https://via.placeholder.com/300x200?text=${Uri.encodeComponent(recipeName)}',
        );
      }
    } catch (e) {
  
    }
    
    return _createSingleFallbackRecipe('detailed_${DateTime.now().millisecondsSinceEpoch}', recipeName);
  }

  // JSON yanıt parse et
  static Map<String, dynamic> _parseJsonResponse(String response) {
    try {
      String jsonStr = response;
      if (jsonStr.contains('```json')) {
        int startIndex = jsonStr.indexOf('{');
        int endIndex = jsonStr.lastIndexOf('}') + 1;
        if (startIndex != -1 && endIndex > startIndex) {
          jsonStr = jsonStr.substring(startIndex, endIndex);
        }
      } else {
        int jsonStart = jsonStr.indexOf('{');
        if (jsonStart != -1) jsonStr = jsonStr.substring(jsonStart);
        int jsonEnd = jsonStr.lastIndexOf('}');
        if (jsonEnd != -1) jsonStr = jsonStr.substring(0, jsonEnd + 1);
      }
      return jsonDecode(jsonStr);
    } catch (e) {
      return {};
    }
  }

  // Tek fallback tarif oluştur 
  static Recipe _createSingleFallbackRecipe(String id, [String? recipeName]) {
    String name = recipeName ?? 'Lezzetli Yemek';
    
    // ID'den gerçek ismi çıkarmaya çalış
    if (recipeName == null && id.startsWith('fallback_')) {
      List<String> parts = id.split('_');
      if (parts.length > 2) {
        name = parts.sublist(2).join(' ').replaceAll('-', ' ');
      }
    }
    
    // Tarif adına göre malzeme ve talimatları özelleştir
    List<String> ingredients = [];
    List<String> instructions = [];
    int cookingTime = 30;
    String difficulty = 'Kolay';
    
    if (name.toLowerCase().contains('patlıcan')) {
      ingredients = [
        'Patlıcan - 2 adet',
        'Soğan - 1 adet',
        'Domates - 2 adet', 
        'Zeytinyağı - 3 yemek kaşığı',
        'Tuz - 1 çay kaşığı',
        'Karabiber - 1/2 çay kaşığı'
      ];
      instructions = [
        'Patlıcanları dilimleyin ve tuzlayın',
        'Soğanları doğrayın',
        'Tavada zeytinyağını ısıtın',
        'Soğanları kavurun',
        'Patlıcanları ekleyin',
        'Domatesleri ekleyip pişirin',
        'Baharatları ekleyin',
        'Servis edin'
      ];
      cookingTime = 35;
    } else if (name.toLowerCase().contains('domates')) {
      ingredients = [
        'Domates - 4 adet',
        'Soğan - 1 adet',
        'Zeytinyağı - 2 yemek kaşığı',
        'Tuz - 1 çay kaşığı',
        'Şeker - 1 çay kaşığı'
      ];
      instructions = [
        'Domatesleri doğrayın',
        'Soğanları ince doğrayın',
        'Tavada zeytinyağını ısıtın',
        'Soğanları kavurun',
        'Domatesleri ekleyin',
        'Tuz ve şeker ekleyin',
        'Kısık ateşte pişirin',
        'Sıcak servis edin'
      ];
      cookingTime = 20;
    } else if (name.toLowerCase().contains('yumurta') || name.toLowerCase().contains('omlet')) {
      ingredients = [
        'Yumurta - 3 adet',
        'Süt - 2 yemek kaşığı',
        'Tereyağı - 1 yemek kaşığı',
        'Tuz - 1/2 çay kaşığı',
        'Karabiber - Biraz'
      ];
      instructions = [
        'Yumurtaları çırpın',
        'Süt, tuz ve karabiberi ekleyin',
        'Tavayı ısıtın',
        'Tereyağını eritin',
        'Yumurta karışımını dökün',
        'Altı pişince katlayın',
        'Servis tabağına alın'
      ];
      cookingTime = 10;
      difficulty = 'Çok Kolay';
    } else if (name.toLowerCase().contains('kabak')) {
      ingredients = [
        'Kabak - 2 adet',
        'Soğan - 1 adet',
        'Zeytinyağı - 2 yemek kaşığı',
        'Dereotu - 1 demet',
        'Tuz - 1 çay kaşığı'
      ];
      instructions = [
        'Kabakları küp şeklinde doğrayın',
        'Soğanları ince doğrayın',
        'Tavada zeytinyağını ısıtın',
        'Soğanları kavurun',
        'Kabakları ekleyin',
        'Tuz ekleyip karıştırın',
        'Dereotu ekleyip servis edin'
      ];
      cookingTime = 25;
    } else if (name.toLowerCase().contains('patates')) {
      ingredients = [
        'Patates - 4 adet',
        'Zeytinyağı - 3 yemek kaşığı',
        'Tuz - 1 çay kaşığı',
        'Kırmızı pul biber - 1/2 çay kaşığı',
        'Kekik - 1 çay kaşığı'
      ];
      instructions = [
        'Patatesleri yıkayın ve soyun',
        'Küp şeklinde doğrayın',
        'Tavada zeytinyağını ısıtın',
        'Patatesleri ekleyin',
        'Baharatları serptin',
        'Altın sarısı olana kadar kızartın',
        'Servis tabağına alın'
      ];
      cookingTime = 30;
    } else if (name.toLowerCase().contains('salata')) {
      ingredients = [
        'Karışık yeşillik - 1 demet',
        'Domates - 2 adet',
        'Salatalık - 1 adet',
        'Zeytinyağı - 2 yemek kaşığı',
        'Limon - 1/2 adet',
        'Tuz - 1/2 çay kaşığı'
      ];
      instructions = [
        'Yeşillikleri yıkayın',
        'Domatesleri dilimleyin',
        'Salatalığı dilimleyin',
        'Tüm malzemeleri karıştırın',
        'Zeytinyağı ve limon ekleyin',
        'Tuzlayıp servis edin'
      ];
      cookingTime = 10;
      difficulty = 'Çok Kolay';
    } else if (name.toLowerCase().contains('çorba')) {
      ingredients = [
        'Ana malzemeler - 2 su bardağı',
        'Su - 4 su bardağı',
        'Soğan - 1 adet',
        'Tereyağı - 1 yemek kaşığı',
        'Tuz - 1 çay kaşığı',
        'Karabiber - 1/2 çay kaşığı'
      ];
      instructions = [
        'Soğanları doğrayın',
        'Tereyağında kavurun',
        'Ana malzemeleri ekleyin',
        'Su ekleyip kaynatın',
        'Baharatları ekleyin',
        '20 dakika pişirin',
        'Sıcak servis edin'
      ];
      cookingTime = 30;
    } else {
      // Genel tarif
      ingredients = [
        '$name için ana malzemeler',
        'Zeytinyağı - 2 yemek kaşığı',
        'Soğan - 1 adet',
        'Tuz - 1 çay kaşığı',
        'Karabiber - 1/2 çay kaşığı'
      ];
      instructions = [
        'Tüm malzemeleri hazırlayın',
        'Soğanları ince doğrayın',
        'Tavada zeytinyağını ısıtın',
        'Soğanları kavurun',
        'Ana malzemeleri ekleyin',
        'Baharatları ekleyip karıştırın',
        'Uygun sürede pişirin',
        'Lezzetli bir şekilde servis edin'
      ];
    }
    
    return Recipe(
      id: id,
      name: name,
      ingredients: ingredients,
      instructions: instructions,
      cookingTime: cookingTime,
      difficulty: difficulty,
      imageUrl: 'https://via.placeholder.com/300x200/4CAF50/white?text=${Uri.encodeComponent(name)}',
    );
  }

  // Gemini API çağrısı
  static Future<String> _generateRecipeSuggestions(List<String> ingredients) async {
    final prompt = '''
Türkiye'den ${ingredients.join(", ")} malzemeleri ile yapılabilecek 15 farklı yemek tarifi öner.
Hem geleneksel hem modern tarifler olsun. Kolay, orta ve zor zorluk seviyelerinden karışık öner.

Yanıtını sadece şu JSON formatında ver:

{
  "recipes": [
    {
      "id": "benzersiz_id",
      "name": "Tarif Adı",
      "ingredients": ["malzeme1", "malzeme2", "malzeme3"],
      "instructions": ["adım1", "adım2", "adım3"],
      "cookingTime": 30,
      "difficulty": "Kolay"
    }
  ]
}

ÖNEMLİ KURALLAR:
- Tam 15 farklı tarif öner
- Her tarif için benzersiz ID oluştur
- Zorluk seviyeleri: "Kolay", "Orta", "Zor" 
- Pişirme süreleri gerçekçi olsun (5-120 dakika arası)
- JSON formatının dışında hiçbir açıklama yazma

Malzemeler: ${ingredients.join(", ")}
    ''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? '';
  }

  // Yanıt parse etme 
  static List<Recipe> parseGeminiResponse(String response, List<String> ingredients) {
    try {
      if (response.isEmpty) return _createFallbackRecipes(ingredients);

      String jsonStr = response;
      
      // JSON temizleme
      if (jsonStr.contains('```json')) {
        int startIndex = jsonStr.indexOf('{');
        int endIndex = jsonStr.lastIndexOf('}') + 1;
        if (startIndex != -1 && endIndex > startIndex) {
          jsonStr = jsonStr.substring(startIndex, endIndex);
        }
      } else {
        int jsonStart = jsonStr.indexOf('{');
        if (jsonStart != -1) jsonStr = jsonStr.substring(jsonStart);
        
        int jsonEnd = jsonStr.lastIndexOf('}');
        if (jsonEnd != -1) jsonStr = jsonStr.substring(0, jsonEnd + 1);
      }

      Map<String, dynamic> jsonData = jsonDecode(jsonStr);
      
      if (jsonData.containsKey('recipes')) {
        List<dynamic> recipesJson = jsonData['recipes'];
        if (recipesJson.isEmpty) return _createFallbackRecipes(ingredients);
        
        List<Recipe> recipes = [];
        for (int i = 0; i < recipesJson.length; i++) {
          var recipeJson = recipesJson[i];
          
          // Benzersiz ID oluştur
          String uniqueId = recipeJson['id']?.toString() ?? 'recipe_${DateTime.now().millisecondsSinceEpoch}_$i';
          
          Recipe recipe = Recipe(
            id: uniqueId,
            name: recipeJson['name']?.toString() ?? 'Bilinmeyen Tarif',
            ingredients: List<String>.from(recipeJson['ingredients'] ?? ingredients),
            instructions: List<String>.from(recipeJson['instructions'] ?? ['Tarif detayları yükleniyor...']),
            cookingTime: (recipeJson['cookingTime'] as num?)?.toInt() ?? 30,
            difficulty: recipeJson['difficulty']?.toString() ?? 'Kolay',
            imageUrl: 'https://via.placeholder.com/300x200?text=${Uri.encodeComponent(recipeJson['name'] ?? 'Tarif')}',
          );
          
          recipes.add(recipe);
        }
        
        return recipes;
      }
      
      return _createFallbackRecipes(ingredients);
    } catch (e) {
  
      return _createFallbackRecipes(ingredients);
    }
  }

  // Fallback tarifler 
  static List<Recipe> _createFallbackRecipes(List<String> ingredients) {
  
    
    List<Map<String, dynamic>> fallbackData = [
      {'name': 'Sebze Sote', 'cookingTime': 20, 'difficulty': 'Kolay'},
      {'name': 'Karışık Salata', 'cookingTime': 15, 'difficulty': 'Kolay'},
      {'name': 'Sebze Çorbası', 'cookingTime': 35, 'difficulty': 'Kolay'},
    ];

    if (ingredients.contains('patlıcan')) {
      fallbackData.addAll([
        {'name': 'Patlıcan Musakka', 'cookingTime': 60, 'difficulty': 'Orta'},
        {'name': 'İmam Bayıldı', 'cookingTime': 40, 'difficulty': 'Kolay'},
        {'name': 'Patlıcan Beğendi', 'cookingTime': 45, 'difficulty': 'Orta'},
        {'name': 'Karnıyarık', 'cookingTime': 50, 'difficulty': 'Orta'},
        {'name': 'Patlıcan Salatası', 'cookingTime': 20, 'difficulty': 'Kolay'},
      ]);
    }

    if (ingredients.contains('kabak')) {
      fallbackData.addAll([
        {'name': 'Kabak Graten', 'cookingTime': 35, 'difficulty': 'Kolay'},
        {'name': 'Kabak Mücver', 'cookingTime': 25, 'difficulty': 'Kolay'},
        {'name': 'Kabak Böreği', 'cookingTime': 45, 'difficulty': 'Orta'},
        {'name': 'Kabak Çorbası', 'cookingTime': 30, 'difficulty': 'Kolay'},
        {'name': 'Kabak Tatlısı', 'cookingTime': 40, 'difficulty': 'Kolay'},
      ]);
    }

    if (ingredients.contains('havuç')) {
      fallbackData.addAll([
        {'name': 'Havuçlu Pilav', 'cookingTime': 25, 'difficulty': 'Kolay'},
        {'name': 'Havuç Salatası', 'cookingTime': 10, 'difficulty': 'Kolay'},
        {'name': 'Havuç Çorbası', 'cookingTime': 25, 'difficulty': 'Kolay'},
        {'name': 'Sebzeli Güveç', 'cookingTime': 45, 'difficulty': 'Orta'},
      ]);
    }

    if (ingredients.contains('domates')) {
      fallbackData.addAll([
        {'name': 'Domates Dolması', 'cookingTime': 50, 'difficulty': 'Orta'},
        {'name': 'Menemen', 'cookingTime': 15, 'difficulty': 'Kolay'},
        {'name': 'Domates Salatası', 'cookingTime': 10, 'difficulty': 'Kolay'},
        {'name': 'Domates Çorbası', 'cookingTime': 25, 'difficulty': 'Kolay'},
      ]);
    }

    if (ingredients.contains('yumurta')) {
      fallbackData.addAll([
        {'name': 'Omlet', 'cookingTime': 10, 'difficulty': 'Kolay'},
        {'name': 'Scrambled Eggs', 'cookingTime': 5, 'difficulty': 'Kolay'},
        {'name': 'Sufle', 'cookingTime': 30, 'difficulty': 'Orta'},
        {'name': 'Yumurtalı Ekmek', 'cookingTime': 8, 'difficulty': 'Kolay'},
      ]);
    }

    if (ingredients.contains('soğan')) {
      fallbackData.addAll([
        {'name': 'Soğan Çorbası', 'cookingTime': 35, 'difficulty': 'Kolay'},
        {'name': 'Karamelize Soğan', 'cookingTime': 30, 'difficulty': 'Kolay'},
        {'name': 'Soğanlı Pilav', 'cookingTime': 25, 'difficulty': 'Kolay'},
      ]);
    }

    if (ingredients.contains('patates')) {
      fallbackData.addAll([
        {'name': 'Patates Kızartması', 'cookingTime': 20, 'difficulty': 'Kolay'},
        {'name': 'Fırında Patates', 'cookingTime': 45, 'difficulty': 'Kolay'},
        {'name': 'Patates Salatası', 'cookingTime': 25, 'difficulty': 'Kolay'},
        {'name': 'Patates Çorbası', 'cookingTime': 30, 'difficulty': 'Kolay'},
      ]);
    }

    // Duplikatları kaldır ve karıştır
    Map<String, Map<String, dynamic>> uniqueRecipes = {};
    for (var recipe in fallbackData) {
      uniqueRecipes[recipe['name']] = recipe;
    }
    
    List<Map<String, dynamic>> finalRecipes = uniqueRecipes.values.toList();
    finalRecipes.shuffle();
    
    List<Recipe> recipes = [];
    
    for (int i = 0; i < finalRecipes.take(15).length; i++) {
      var data = finalRecipes[i];
      
      // Benzersiz ID oluştur
      String uniqueId = 'fallback_${DateTime.now().millisecondsSinceEpoch}_$i';
      
      Recipe recipe = Recipe(
        id: uniqueId,
        name: data['name'],
        ingredients: ingredients + ['Tuz', 'Karabiber'],
        instructions: [
          'Malzemeleri temizleyin ve hazırlayın',
          'Uygun pişirme tekniğini uygulayın',
          'Lezzet kontrolü yapın',
          'Sıcak olarak servis edin'
        ],
        cookingTime: data['cookingTime'],
        difficulty: data['difficulty'],
        imageUrl: 'https://via.placeholder.com/300x200?text=${Uri.encodeComponent(data['name'])}',
      );
      
      recipes.add(recipe);
      
      // Fallback tariflerini de cache'e ekle
      _recipeCache[uniqueId] = recipe;
  
    }
    
    return recipes;
  }

  // ...
}