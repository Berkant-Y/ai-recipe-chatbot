import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../utils/constants.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({
    Key? key,
    required this.recipeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarif Detayı'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Recipe?>(
        future: RecipeService.getRecipeById(recipeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Tarif bulunamadı', 
                    style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                  Text('ID: $recipeId', 
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            );
          }

          Recipe recipe = snapshot.data!;
          

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tarif başlığı ve bilgiler
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            _buildInfoChip(Icons.access_time, '${recipe.cookingTime} $kMinuteLabel', Colors.orange),
                            SizedBox(width: 12),
                            _buildInfoChip(Icons.bar_chart, recipe.difficulty, Colors.blue),
                            SizedBox(width: 12),
                            _buildInfoChip(Icons.restaurant, '${recipe.ingredients.length} malzeme', Colors.purple),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _buildSectionCard('Malzemeler', Icons.shopping_cart,
                  Column(
                    children: recipe.ingredients.map((ingredient) => 
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.fiber_manual_record, size: 8, color: Colors.green),
                            SizedBox(width: 12),
                            Expanded(child: Text(ingredient, style: TextStyle(fontSize: 16))),
                          ],
                        ),
                      )).toList(),
                  ),
                ),
                SizedBox(height: 16),
                _buildSectionCard('Yapılış', Icons.list_alt,
                  Column(
                    children: recipe.instructions.asMap().entries.map((entry) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24, height: 24,
                              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text('${entry.key + 1}',
                                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(child: Text(entry.value, style: TextStyle(fontSize: 16))),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _addToFavorites(context, recipe),
                    icon: Icon(Icons.favorite),
                    label: Text('Favorilere Ekle'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, Widget content) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: kPrimaryColor),
                SizedBox(width: 8),
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor)),
              ],
            ),
            SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }

  void _addToFavorites(BuildContext context, Recipe recipe) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${recipe.name} favorilere eklendi!'),
        backgroundColor: kPrimaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }
}