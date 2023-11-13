import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/complex_recipe_search.dart';
import 'package:tasty_bytes/shared/color_palette.dart';

class ComplexRecipeCard extends StatelessWidget {
  final ComplexRecipe complexRecipe;
  final void Function() onTap;
  const ComplexRecipeCard({super.key, required this.complexRecipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: Image.network(
                complexRecipe.image,
                fit: BoxFit.cover,
              )
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            constraints: const BoxConstraints(maxHeight: 55),
            color: colorWhite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                complexRecipe.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: colorBlack, fontWeight: FontWeight.w600, fontSize: 17),
              ),
            ),
          ),
          Column(
            children: [
              // Used Ingredients
              ListTileTheme(
                dense: true,
                child: ExpansionTile(
                  title: Text('Used Ingredients: ${complexRecipe.usedIngredients.length}', style: const TextStyle(fontSize: 14,),),
                  shape: const Border(),
                  iconColor: primaryColor,
                  collapsedIconColor: colorBlack,
                  textColor: primaryColor,
                  children: List<Container>.generate(complexRecipe.usedIngredients.length, (index) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              complexRecipe.usedIngredients[index].name, 
                              style: const TextStyle(color: colorBlack),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ),
                          Text(
                            '${complexRecipe.usedIngredients[index].amount.toStringAsFixed(2)} ${complexRecipe.usedIngredients[index].unitShort}', 
                            style: const TextStyle(color: colorBlack),
                          )
                        ],
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 40,
                          width: 50,
                          child: Image.network(complexRecipe.usedIngredients[index].image, fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
              // Missing Ingredients
              ListTileTheme(
                dense: true,
                child: ExpansionTile(
                  title: Text('Missing Ingredients: ${complexRecipe.missedIngredients.length}', style: const TextStyle(fontSize: 14,),),
                  shape: const Border(),
                  iconColor: primaryColor,
                  collapsedIconColor: colorBlack,
                  textColor: primaryColor,
                  children: List<Container>.generate(complexRecipe.missedIngredients.length, (index) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              complexRecipe.missedIngredients[index].name, 
                              maxLines: 2, 
                              overflow: TextOverflow.ellipsis, 
                              style: const TextStyle(color: colorBlack),
                            )
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            '${complexRecipe.missedIngredients[index].amount.toStringAsFixed(2)} ${complexRecipe.missedIngredients[index].unitShort}', 
                            style: const TextStyle(color: colorBlack),
                          )
                        ],
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 40,
                          width: 50,
                          child: Image.network(complexRecipe.missedIngredients[index].image, fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}