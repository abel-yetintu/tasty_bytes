// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bytes/models/recipes_by_category.dart';
import 'package:tasty_bytes/pages/recipe_info.dart';
import 'package:tasty_bytes/providers/recipe_information_provider.dart';
import 'package:tasty_bytes/providers/saved_recipes_provider.dart';
import 'package:tasty_bytes/shared/color_palette.dart';
import 'package:tasty_bytes/shared/error_message.dart';
import 'package:tasty_bytes/widgets/saved_recipe_card.dart';

class SavedRecipes extends StatefulWidget {
  const SavedRecipes({super.key});

  @override
  State<SavedRecipes> createState() => _SavedRecipesState();
}

class _SavedRecipesState extends State<SavedRecipes> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    if(Provider.of<SavedRecipesProvider>(context, listen: false).search.isNotEmpty) {
      _textEditingController.text = Provider.of<SavedRecipesProvider>(context, listen: false).search;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 24.0, left: 24.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              style: const TextStyle(
                  fontSize: 12,
                  color: colorBlack,
                  decoration: TextDecoration.none),
              cursorColor: accentColor,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(40)),
                filled: true,
                fillColor: colorWhite,
                hintText: 'Search saved recipes',
                hintStyle: const TextStyle(color: accentColor),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: colorBlack, size: 20,),
                  onPressed: () {
                    if(_textEditingController.text.isNotEmpty) {
                      _textEditingController.clear();
                      Provider.of<SavedRecipesProvider>(context, listen: false).getFilteredRecipes(null);
                      Provider.of<SavedRecipesProvider>(context, listen: false).search = '';
                    }
                  },
                ),
              ),
              onChanged: (value) {
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  if (value.trim().isNotEmpty) {
                    Provider.of<SavedRecipesProvider>(context, listen: false).getFilteredRecipes(value.toLowerCase());
                  } else {
                    Provider.of<SavedRecipesProvider>(context, listen: false).getFilteredRecipes(null);
                  }
                });
              },
              
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Consumer<SavedRecipesProvider>(
                builder: (context, value, child) {
                  return FutureBuilder(
                    future: value.recipes,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return loadingWidget(context, 50);
                      } else if (snapshot.hasData) {
                        final recipes = snapshot.data as List<Recipe>;
                        if (recipes.isEmpty) {
                          return const ErrorMessage(
                            color: accentColor,
                            message: 'No recipe saved.',
                            imgPath: 'assets/icons/empty.png',
                          );
                        } else {
                          return recipesGrid(
                            recipes: recipes,
                            context: context,
                          );
                        }
                      } else {
                        return ErrorMessage(
                          color: accentColor,
                          message: snapshot.error.toString(),
                          imgPath: 'assets/icons/empty.png',
                        );
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget recipesGrid({
    required List<Recipe> recipes,
    required BuildContext context,
  }) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: recipes.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 5, left: 5, bottom: 10),
          child: SavedRecipeCard(
            recipe: recipes[index],
            onTap: () async {
              var result = await Navigator.push(context, MaterialPageRoute(
                builder: (_) {
                  return ChangeNotifierProvider<RecipeInformationProvider>(
                    create: (context) => RecipeInformationProvider(),
                    child: ChangeNotifierProvider.value(
                      value: Provider.of<SavedRecipesProvider>(context,
                          listen: false),
                      child: RecipeInfo(
                        recipeID: recipes[index].id,
                      ),
                    ),
                  );
                },
              ));
              if (result == 'error') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'An Error occured please tyr again.',
                    style: TextStyle(color: colorWhite),
                  ),
                  backgroundColor: accentColor,
                ));
              }
            },
            onDelete: () async {
              var result = await Provider.of<SavedRecipesProvider>(context,
                      listen: false)
                  .deleteRecipe(recipes[index]);
              if (result != -1) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: accentColor,
                  content: const Text(
                    'Recipe has been deleted.',
                    style: TextStyle(color: colorBlack),
                  ),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                      label: 'undo',
                      textColor: colorBlack,
                      onPressed: () async {
                        Provider.of<SavedRecipesProvider>(context,
                                listen: false)
                            .insertRecipe(recipes[index]);
                      }),
                ));
              }
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Widget loadingWidget(BuildContext context, double size) {
    return Center(
      child: SpinKitSpinningLines(
        color: accentColor,
        size: size,
      ),
    );
  }
}
