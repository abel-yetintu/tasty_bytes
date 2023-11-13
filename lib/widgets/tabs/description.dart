import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/recipe_information.dart';
import 'package:tasty_bytes/shared/color_palette.dart';
import 'package:tasty_bytes/widgets/ingredient.dart';
import 'package:expandable_text/expandable_text.dart';

class Description extends StatelessWidget {
  final RecipeInformation recipeInformation;
  const Description({super.key, required this.recipeInformation});

  String _formatSummaryString(String summary) {
    String result = summary
      .replaceAll('<b>', '')
      .replaceAll('</b>', '')
      .replaceAll('<a href=', '')
      .replaceAll('</a>', '')
      .replaceAll('>', ' ');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipeInformation.title, 
            style: const TextStyle(color: colorBlack, fontWeight: FontWeight.w600, fontSize: 18), 
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10,), 
          Row(
            children: [
              Row(
                children: [
                  const Icon(Icons.schedule, color: accentColor,),
                  const SizedBox(width: 4,),
                  Text('${recipeInformation.readyInMinutes.toString()} min(s)', style: const TextStyle(color: accentColor, fontSize: 14),)
                ],
              ),
              const SizedBox(width: 16,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    child: Image.asset('assets/icons/fire.png', color: accentColor,),
                  ),
                  const SizedBox(width: 4,),
                  Text('${recipeInformation.nutrition.nutrients[0].amount.round()} Cal', style: const TextStyle(color: accentColor,),)
                ],
              ),
              const SizedBox(width: 16,),
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    child: Image.asset('assets/icons/dinner.png', color: accentColor,),
                  ),
                  const SizedBox(width: 8,),
                  Text('${recipeInformation.servings.toString()} serving(s)', style: const TextStyle(color: accentColor,),)
                ],
              ), 
            ],
          ),
          const SizedBox(height: 10,),
          const Text('Summary', style: TextStyle(color: colorBlack, fontSize: 18, fontWeight: FontWeight.w600),),
          const SizedBox(height: 10,),
          Container(
            constraints: const BoxConstraints(maxHeight: 100),
            child: SingleChildScrollView(
              child: ExpandableText(
                _formatSummaryString(recipeInformation.summary),
                expandText: 'show more',
                collapseText: 'show less',
                style: const TextStyle(color: Colors.grey),
                maxLines: 3,
                linkColor: accentColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              const Text('Ingredients', style: TextStyle(color: colorBlack, fontSize: 18, fontWeight: FontWeight.w600),),
              Text('${recipeInformation.extendedIngredients.length} Items', style: const TextStyle(color: accentColor, fontSize: 14, fontWeight: FontWeight.w600),),
            ],
          ),
          const SizedBox(height: 14,),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: recipeInformation.extendedIngredients.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 12), 
                  child: Ingredient(extendedIngredient: recipeInformation.extendedIngredients[index],)
                );
              }
            ),
          )
        ],
      ),
    );
  }
}