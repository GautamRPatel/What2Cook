import 'package:flutter/material.dart';
import 'package:what2cook/models/Recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  static const Color bgColor = Color(0xFFEDEFE6);
  static const Color cardColor = Color.fromARGB(255, 242, 244, 230);
  static const Color primaryGreen = Color.fromARGB(255, 133, 163, 118);
  static const Color darkText = Color.fromARGB(255, 45, 51, 42);
  static const Color lightText = Color(0xFF6D6D6D);

  @override
  Widget build(BuildContext context) {
    final ingredients = recipe.ingredients.toString().split(",");

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [

          /// 🔥 TOP IMAGE
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.42,
            width: double.infinity,
            child: Image.asset(
              "assets/images/ChatGPT Image Feb 28, 2026, 03_49_00 PM.png", // <-- You set manually
              fit: BoxFit.cover,
            ),
          ),

          /// 🔙 Back Button
          Positioned(
            top: 45,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.4),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          /// 📄 CONTENT CARD
          DraggableScrollableSheet(
            initialChildSize: 0.62,
            minChildSize: 0.62,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                decoration: const BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// 🏷 TITLE
                      Text(
                        recipe.name ?? "",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// TAGS
                      Row(
                        children: [
                          _tag("VEGAN"),
                          const SizedBox(width: 8),
                          _tag("GLUTEN-FREE"),
                          const SizedBox(width: 8),
                          _tag("${recipe.totalTime} MIN"),
                        ],
                      ),

                      const SizedBox(height: 22),

                      /// DESCRIPTION
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipe.instructions ?? "",
                        style: const TextStyle(
                          color: lightText,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// INGREDIENTS
                      const Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                      const SizedBox(height: 12),

                      ...ingredients.map(
                            (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// Green Bullet
                              Container(
                                margin: const EdgeInsets.only(top: 6, right: 10),
                                height: 8,
                                width: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryGreen,
                                ),
                              ),

                              /// Ingredient Text
                              Expanded(
                                child: Text(
                                  item.trim(),
                                  style: const TextStyle(
                                    color: darkText,
                                    fontSize: 15,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// COOKING TIME
                      const Text(
                        "Cooking Time",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _timeCard("Prep", recipe.prepTime),
                          _timeCard("Cook", recipe.cookTime),
                          _timeCard("Total", recipe.totalTime),
                        ],
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// 🌿 TAG CHIP
  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryGreen),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: primaryGreen,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  /// ⏱ TIME CARD
  Widget _timeCard(String label, int time) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            "$time min",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: lightText,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}