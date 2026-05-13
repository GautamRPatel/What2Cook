class Recipe {
  final String name;
  final List<String> ingredients;
  final String instructions;
  final int prepTime;
  final int cookTime;
  final int totalTime;
  final String servings;
  final String cuisine;
  final String diet;
  final double similarityScore;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTime,
    required this.cookTime,
    required this.totalTime,
    required this.servings,
    required this.cuisine,
    required this.diet,
    required this.similarityScore,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json["recipe_name"],
      ingredients: json["ingredients"].toString().split(","),
      instructions: json["instructions"],
      prepTime: json["prep_time"],
      cookTime: json["cook_time"],
      totalTime: json["total_time"],
      servings: json["servings"],
      cuisine: json["cuisine"],
      diet: json["diet"],
      similarityScore:
      (json["similarity_score"] as num).toDouble(),
    );
  }
}