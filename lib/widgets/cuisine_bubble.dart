import 'package:flutter/material.dart';
import 'package:tasty_bytes/shared/color_palette.dart';
import 'package:tasty_bytes/shared/cuisine.dart';

class CuisineBubble extends StatelessWidget {
  final bool selected;
  final Cuisine cuisine;
  final void Function() onTap;
  const CuisineBubble({super.key, required this.cuisine, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return selected ?
    GestureDetector(
      onTap: onTap,
      child: Column(
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
                child: Image.asset(cuisine.imgPath, fit: BoxFit.cover,),
              ),
              Container(
                height: 75,
                width: 75,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(75, 0, 0, 0)
                ),
                clipBehavior: Clip.hardEdge,
                child: const Icon(Icons.check, color: colorWhite, size: 40,),
              )
            ],
          ),
          const SizedBox(height: 8,),
          Text(cuisine.apiName, style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w500, fontSize: 12),)
        ],
      ),
    ) :
    GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: const BoxDecoration(
              shape: BoxShape.circle
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(cuisine.imgPath, fit: BoxFit.cover,),
          ),
          const SizedBox(height: 8,),
          Text(cuisine.apiName, style: const TextStyle(color: colorBlack, fontWeight: FontWeight.w500, fontSize: 12),)
        ],
      ),
    );
  }
}
