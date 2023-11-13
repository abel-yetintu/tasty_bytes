import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/recipe_information.dart';
import 'package:tasty_bytes/widgets/recipe_step.dart';

class Direction extends StatelessWidget {
  final RecipeInformation recipeInformation;
  const Direction({super.key, required this.recipeInformation});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: recipeInformation.analyzedInstructions[0].steps.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: RecipeStep(step: recipeInformation.analyzedInstructions[0].steps[index],)
            );
          },
        ));
  }
}
