import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';
  
  static String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  static Future<String> generateRecipeSuggestions(List<String> ingredients) async {
    
    // YENİ İYİLEŞTİRİLMİŞ PROMPT - JSON formatında yanıt ister
    final prompt = '''
Sen bir yemek tarifi asistanısın. Kullanıcının elindeki malzemelerle yapabileceği 3 tarifi JSON formatında ver.

Malzemeler: ${ingredients.join(', ')}

Yanıtını şu JSON formatında ver:

{
  "recipes": [
    {
      "name": "Tarif Adı",
      "ingredients": [
        "malzeme 1",
        "malzeme 2"
      ],
      "instructions": [
        "1. adım",
        "2. adım"
      ],
      "cookingTime": 30,
      "difficulty": "Kolay"
    }
  ]
}

Türkçe yanıt ver. En fazla 3 tarif öner. Her tarif için gerçekçi malzeme listesi ve adım adım talimatlar ekle.
    ''';


    try {
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [{
            'parts': [{
              'text': prompt
            }]
          }]
        }),
      );


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String result = data['candidates'][0]['content']['parts'][0]['text'];
        return result;
      } else {
        throw Exception('API çağrısı başarısız: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Hata: $e');
    }
  }
}