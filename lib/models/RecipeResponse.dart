import 'package:what2cook/models/Recipe.dart';

class RecipeResponse {
  final List<String> detectedVegetables;
  final List<Recipe> topRecipes;

  RecipeResponse({
    required this.detectedVegetables,
    required this.topRecipes,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    return RecipeResponse(
      detectedVegetables:
      List<String>.from(json["detected_vegetables"]),

      topRecipes: (json["top_3_recipes"] as List)
          .map((e) => Recipe.fromJson(e))
          .toList(),
    );
  }
}

