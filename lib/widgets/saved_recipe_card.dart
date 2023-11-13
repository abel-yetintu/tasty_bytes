import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:tasty_bytes/models/recipes_by_category.dart';
import 'package:tasty_bytes/shared/color_palette.dart';

class SavedRecipeCard extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onDelete;
  final Recipe recipe;
  const SavedRecipeCard({super.key, required this.onTap, required this.recipe, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: 200,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () {
          showPopover(
            constraints: const BoxConstraints(
              maxHeight: 250,
              maxWidth: 250
            ),
            direction: PopoverDirection.top,
            backgroundColor: accentColor,
            context: context,
            bodyBuilder: (context) {
              return popUpMenu();
            },
          );
        },
        child: Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          clipBehavior: Clip.hardEdge,
          elevation: 0,
          color: colorWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          recipe.image,
                          fit: BoxFit.cover,
                        )))),
              SizedBox(
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    recipe.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: colorBlack, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget popUpMenu() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onDelete,
            child: const Text('Delete Recipe', style: TextStyle(color: colorBlack),),
          )
        ],
      ),
    );
  }
}
