import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bytes/models/recipes_by_category.dart';
import 'package:tasty_bytes/pages/recipe_info.dart';
import 'package:tasty_bytes/providers/recipe_information_provider.dart';
import 'package:tasty_bytes/providers/recipes_by_category_provider.dart';
import 'package:tasty_bytes/providers/saved_recipes_provider.dart';
import 'package:tasty_bytes/shared/color_palette.dart';
import 'package:tasty_bytes/shared/error_message.dart';
import 'package:tasty_bytes/shared/meal_type.dart';
import 'package:tasty_bytes/widgets/meal_type_bubble.dart';
import 'package:tasty_bytes/widgets/recipe_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    var provider = Provider.of<RecipesByCategoryProvider>(context, listen: false);
    if(provider.recipes.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(provider.term.isEmpty) {
          provider.getRecipesByCategory(MealType.values[provider.selectedIndex], null);
        } else {
          provider.getRecipesByCategory(MealType.values[provider.selectedIndex], provider.term);
        }
     });
    }
    if(provider.term.isNotEmpty) {
      _textEditingController.text = provider.term;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 24, left: 24, top: 16),
            child: Text(
              'Explore some recipes and find your next meal.',
              style: TextStyle(
                  color: colorBlack, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Consumer<RecipesByCategoryProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 24, left: 24),
                child: TextField(
                  controller: _textEditingController,
                  style: const TextStyle(
                      fontSize: 12,
                      color: colorBlack,
                      decoration: TextDecoration.none),
                  cursorColor: accentColor,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40)),
                    filled: true,
                    fillColor: colorWhite,
                    hintText: 'Search for recipes',
                    hintStyle: const TextStyle(color: accentColor),
                    suffixIcon: const Icon(
                      Icons.mic,
                      color: colorBlack,
                      size: 20,
                    ),
                  ),
                  onChanged: (value) {
                    if(value.trim().isEmpty) {
                        provider.term = '';
                      } else {
                        provider.term = value;
                      }
                  },
                  onSubmitted: (value) {
                    if(value.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a search term first', style: TextStyle(color: colorBlack),),
                          backgroundColor: accentColor,
                        ),
                      );
                    } else {
                      provider.getRecipesByCategory(MealType.values[provider.selectedIndex], value);
                    }
                  },
                ),
              );
            }
          ),
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Categories',
              style: TextStyle(
                  color: colorBlack, fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Consumer<RecipesByCategoryProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 24),
                child: SizedBox(
                  height: 101,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: MealType.values.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: MealTypeBubble(
                            mealType: MealType.values[index], 
                            selected: MealType.values[index].index == provider.selectedIndex ),
                        ),
                        onTap: () {
                          if(provider.selectedIndex != index || provider.error != null) {
                            provider.selectedIndex = index;
                            if(_textEditingController.text.trim().isNotEmpty) {
                              provider.getRecipesByCategory(MealType.values[index], _textEditingController.text);
                            } else {
                              provider.getRecipesByCategory(MealType.values[index], null);
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Consumer<RecipesByCategoryProvider>(
              builder: (context, provider, child) {
                var recipes = provider.recipes;
                return provider.isLoading ? loadingWidget(context, 50)
                  : provider.error != null ? 
                   ErrorMessage(
                    message: provider.error!.message, 
                    imgPath: provider.error!.message == 'No internet connection' ? 'assets/icons/no_connection.png' : 'assets/icons/error.png',
                    color: accentColor,
                  )
                  : provider.error == null && provider.recipes.isNotEmpty ?
                   Padding(
                    padding: const EdgeInsets.only(left: 19, right: 19),
                    child: recipesGrid(recipes: recipes, context: context),
                  )
                  : const ErrorMessage(
                    color: accentColor,
                    message: 'No recipe found.',
                    imgPath: 'assets/icons/empty.png',
                  );
              },
            )
          )
        ],
      ),
    );
  }

  Widget recipesGrid({ required List<Recipe> recipes, required BuildContext context}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 5, left: 5, bottom: 10),
          child: RecipeCard(
            recipe: recipes[index],
            onTap: () async {
              var result = await Navigator.push(context, MaterialPageRoute(
                builder: (_) {
                  return ChangeNotifierProvider(
                    create: (context) => RecipeInformationProvider(),
                    child: ChangeNotifierProvider.value(
                      value: Provider.of<SavedRecipesProvider>(context, listen: false),
                      child: RecipeInfo(recipeID: recipes[index].id,)
                    ),
                  );
                },
              ));
              if(result == 'error') {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('An Error occured please tyr again.', style: TextStyle(color: colorWhite),), 
                    backgroundColor: accentColor,
                  )
                );
              }
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
