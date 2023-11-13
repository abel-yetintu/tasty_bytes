import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/recipe_information.dart';
import 'package:tasty_bytes/shared/color_palette.dart';

class Ingredient extends StatelessWidget {
  final ExtendedIngredient extendedIngredient;
  const Ingredient({super.key,required this.extendedIngredient});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorWhite,
      margin: const EdgeInsets.all(0),
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                 ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    height: 40,
                    width: 50,
                    child: Image.network('https://spoonacular.com/cdn/ingredients_500x500/${extendedIngredient.image}', fit: BoxFit.cover,),
                    ),
                  ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Text(extendedIngredient.name, overflow: TextOverflow.ellipsis, maxLines: 2,)
                )
              ],
            ),
          ),
          const SizedBox(width: 8,),
          Text('${extendedIngredient.amount.toStringAsFixed(2)} ${extendedIngredient.measures.metric.unitShort}')
        ],
      ),
    );
  }
}