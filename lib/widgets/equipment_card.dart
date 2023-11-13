import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/recipe_information.dart';
import 'package:tasty_bytes/shared/color_palette.dart';

class EquipmentCard extends StatelessWidget {
  final Ent equipment;
  const EquipmentCard({super.key, required this.equipment});

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
             child: Image.network('https://spoonacular.com/cdn/equipment_500x500/${equipment.image}', fit: BoxFit.cover,),
             ),
          ),
          const SizedBox(width: 10,),
          Expanded(child: Text(equipment.name, maxLines: 2, overflow: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }
}