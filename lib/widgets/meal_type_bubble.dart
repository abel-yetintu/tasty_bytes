import 'package:flutter/material.dart';
import 'package:tasty_bytes/shared/color_palette.dart';
import 'package:tasty_bytes/shared/meal_type.dart';

class MealTypeBubble extends StatelessWidget {
  final MealType mealType;
  final bool selected;
  const MealTypeBubble({super.key, required this.mealType, required this.selected});

  @override
  Widget build(BuildContext context) {
    return !selected ? 
      Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: const BoxDecoration(
            shape: BoxShape.circle
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(mealType.imgPath, fit: BoxFit.cover,),
        ),
        const SizedBox(height: 8,),
        Text(mealType.apiName, style: const TextStyle(color: colorBlack, fontWeight: FontWeight.w500, fontSize: 12),)
      ],
    )
    : Column(
      children: [
        Stack(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: const BoxDecoration(
                shape: BoxShape.circle
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(mealType.imgPath, fit: BoxFit.cover,),
            ),
            Container(
              height: 75,
              width: 75,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(75, 0, 0, 0)
              ),
              clipBehavior: Clip.hardEdge,
              // child: const Icon(Icons.check, color: colorWhite, size: 40,),
            )
          ],
        ),
        const SizedBox(height: 8,),
        Text(mealType.apiName, style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w500, fontSize: 12),)
      ],
    );
  }
}
