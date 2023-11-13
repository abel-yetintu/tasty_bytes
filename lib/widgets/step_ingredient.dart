import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/recipe_information.dart';
import 'package:tasty_bytes/shared/color_palette.dart';

class StepIngredient extends StatelessWidget {
  final Ent ingredient;
  const StepIngredient({super.key,required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      margin: const EdgeInsets.all(0),
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
           ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 40,
              width: 50,
              child: Image.network('https://spoonacular.com/cdn/ingredients_500x500/${ingredient.image}', fit: BoxFit.cover,),
              ),
            ),
          const SizedBox(width: 10,),
          Expanded(child: Text(ingredient.name, maxLines: 2, overflow: TextOverflow.ellipsis,))
        ],
      ),
    );
  }
}