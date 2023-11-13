import 'package:flutter/material.dart' hide Step;
import 'package:tasty_bytes/shared/color_palette.dart';
import 'package:tasty_bytes/models/recipe_information.dart';
import 'package:tasty_bytes/widgets/equipment_card.dart';
import 'package:tasty_bytes/widgets/step_ingredient.dart';

class RecipeStep extends StatelessWidget {
  final Step step;
  const RecipeStep({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: secondaryColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step ${step.number}',
              style: const TextStyle(color: accentColor, fontSize: 24, fontWeight: FontWeight.w600,),
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                const Text('Ingredients', style: TextStyle(color: colorBlack, fontSize: 18, fontWeight: FontWeight.w600),),
                Text('${step.ingredients.length} Items', style: const TextStyle(color: accentColor, fontSize: 14, fontWeight: FontWeight.w600),),
              ],
            ),
            const SizedBox(height: 10,),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: step.ingredients.length,
              itemBuilder: (context, index) {
                return Container(padding: const EdgeInsets.only(bottom: 12) , child: StepIngredient(ingredient: step.ingredients[index]),);
              }
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                const Text('Equipment', style: TextStyle(color: colorBlack, fontSize: 18, fontWeight: FontWeight.w600),),
                Text('${step.equipment.length} Items', style: const TextStyle(color: accentColor, fontSize: 14, fontWeight: FontWeight.w600),),
              ],
            ),
            const SizedBox(height: 10,),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: step.equipment.length,
              itemBuilder: (context, index) {
                return Container(padding: const EdgeInsets.only(bottom: 12) ,child: EquipmentCard(equipment: step.equipment[index],));
              }
            ),
            const SizedBox(height: 10,),
            const Text('Instruction', style: TextStyle(color: colorBlack, fontSize: 18, fontWeight: FontWeight.w600),),
            const SizedBox(height: 8,),
            Text(
              step.step, 
              style: const TextStyle(color: colorBlack,),
            ),
          ],
        ),
      ),
    );
  }
}