import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bytes/models/complex_recipe_search.dart';
import 'package:tasty_bytes/pages/recipe_info.dart';
import 'package:tasty_bytes/providers/recipe_information_provider.dart';
import 'package:tasty_bytes/providers/saved_recipes_provider.dart';
import 'package:tasty_bytes/providers/search_provider.dart';
import 'package:tasty_bytes/shared/api_exceptions.dart';
import 'package:tasty_bytes/shared/color_palette.dart';
import 'package:tasty_bytes/shared/cuisine.dart';
import 'package:tasty_bytes/shared/error_message.dart';
import 'package:tasty_bytes/shared/meal_type.dart';
import 'package:tasty_bytes/widgets/complex_recipe_card.dart';
import 'package:tasty_bytes/widgets/cuisine_bubble.dart';
import 'package:tasty_bytes/widgets/search_meal_type_bubble.dart';
import 'package:tuple/tuple.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _ingredientTextController = TextEditingController();
  final TextEditingController _recipeNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      body: Selector<SearchProvider,Tuple4<List<ComplexRecipe>, ApiException?, bool, bool>>(
        selector: (_, provider) => Tuple4(provider.recipes, provider.error, provider.isLoading, provider.showSearchFilters),
        builder: (_, data, __) {
          return data.item3 ? 
          const Center(
            child: SpinKitSpinningLines(
              color: accentColor,
              size: 50,
            ),
          )
          : data.item4 ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24, left: 24, top: 16),
                child: Selector<SearchProvider,String>(
                  selector: (_, provider) => provider.query,
                  builder: (context, value, child) {
                    _recipeNameTextController.text = value;
                    return TextField(
                      controller: _recipeNameTextController,
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
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: colorWhite,
                        hintText: 'Recipe name',
                        hintStyle: const TextStyle(color: accentColor),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear,),
                          color: colorBlack,
                          iconSize: 20,
                          onPressed: () {
                            _recipeNameTextController.clear();
                            Provider.of<SearchProvider>(context,listen: false).query = '';
                          },
                        ),
                      ),
                      onChanged: (value) {
                        Provider.of<SearchProvider>(context,listen: false).query = value;
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: colorWhite,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Popular Cuisines',
                        style: TextStyle(
                            color: colorBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Consumer<SearchProvider>(
                      builder: (context, provider, child) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: SizedBox(
                            height: 101,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Cuisine.values.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: CuisineBubble(
                                    cuisine: Cuisine.values[index],
                                    selected: provider.cuisines.contains(Cuisine.values[index]),
                                    onTap: () {
                                      var cuisine = Cuisine.values[index];
                                      if(provider.cuisines.contains(cuisine)) {
                                        provider.removeCuisine(cuisine);
                                      } else {
                                        provider.addCuisine(cuisine);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }, 
                    ),
                  ],
                ),
              ), 
              const SizedBox(height: 16,),
              Container(
                color: colorWhite,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Include Ingredients',
                        style: TextStyle(
                            color: colorBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextField(
                        controller: _ingredientTextController,
                        style: const TextStyle(
                            fontSize: 12,
                            color: colorBlack,
                            decoration: TextDecoration.none),
                        cursorColor: accentColor,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: secondaryColor,
                          hintText: 'Enter the ingredient',
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add,),
                            color: colorBlack,
                            iconSize: 20,
                            onPressed: () {
                              if(_ingredientTextController.text.isEmpty) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: accentColor,
                                    content: Text('Please enter an ingredient first.', style: TextStyle(color: colorBlack),),
                                  )
                                );
                              } else {
                                Provider.of<SearchProvider>(context, listen: false).addIngredient(_ingredientTextController.text.trim());
                                _ingredientTextController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Consumer<SearchProvider>(
                      builder: (context, provider, child) {
                        return provider.ingredients.isNotEmpty ?
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Container(
                            constraints: const BoxConstraints(maxHeight: 50),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: provider.ingredients.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8), 
                                  child: InputChip(
                                    label: Text(provider.ingredients[index]),
                                    labelStyle: const TextStyle(color: colorBlack),
                                    backgroundColor: accentColor,
                                    onDeleted: () {
                                      provider.removeIngredient(provider.ingredients[index]);
                                    },
                                  )
                                );
                              },
                            ),
                          ),
                        ) : 
                        const Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Chip(
                            label: Text('No ingredient added.', style: TextStyle(color: Colors.grey),),
                            backgroundColor: secondaryColor,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                color: colorWhite,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            color: colorBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Consumer<SearchProvider>(
                      builder: (context, provider, child) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: SizedBox(
                            height: 101,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: MealType.values.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: SearchMealTypeBubble(
                                    mealType: MealType.values[index], 
                                    selected: provider.mealType.contains(MealType.values[index]),
                                    onTap: () {
                                      var mealType = MealType.values[index];
                                      if(provider.mealType.contains(mealType)) {
                                        provider.removeMealType(mealType);
                                      } else {
                                        provider.addMealType(mealType);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        alignment: Alignment.center,
                        child: const Text('Search', style: TextStyle(color: colorBlack),),
                      ),
                      onTap: () {
                        var provider = Provider.of<SearchProvider>(context,listen: false);
                        if(provider.query.isEmpty && provider.cuisines.isEmpty && provider.ingredients.isEmpty && provider.mealType.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: accentColor,
                              content: Text('Please select or enter atleast one criteria', style: TextStyle(color: colorBlack),),
                            )
                          );
                        } else {
                          provider.complexRecipeSearch();
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          )
          : data.item1.isNotEmpty && data.item2 == null ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  color: colorWhite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Found ${data.item1.length} recipes', style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w600),),
                            GestureDetector(
                              child: const Text('Clear Search', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),),
                              onTap: () {
                                 Provider.of<SearchProvider>(context, listen: false).clearSearch();
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            const Text(
                              'Name:  ', 
                              style: TextStyle(fontWeight: FontWeight.w500, color: accentColor),
                            ),
                            Expanded(
                              child: Text(
                                Provider.of<SearchProvider>(context,listen: false).query, 
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            const Text(
                              'Cuisines:  ',
                              style: TextStyle(fontWeight: FontWeight.w500, color: accentColor),
                            ),
                            Expanded(
                              child: Text(
                                Provider.of<SearchProvider>(context,listen: false).getStringCusine(),
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          children: [
                            const Text(
                              'Ingredients:  ',
                              style: TextStyle(fontWeight: FontWeight.w500, color: accentColor),
                            ),
                            Expanded(
                              child: Text(
                                Provider.of<SearchProvider>(context,listen: false).getStringIngredients(),
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          children: [
                            const Text(
                              'Categories:  ',
                              style: TextStyle(fontWeight: FontWeight.w500, color: accentColor),
                            ),
                            Expanded(
                              child: Text(
                                Provider.of<SearchProvider>(context,listen: false).getStringMealTypes(),
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              Expanded(
                child: ListView.builder(
                  itemCount: data.item1.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                      child: ComplexRecipeCard(
                        complexRecipe: data.item1[index],
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) {
                              return ChangeNotifierProvider(
                                create: (context) => RecipeInformationProvider(),
                                child: ChangeNotifierProvider.value(
                                  value: Provider.of<SavedRecipesProvider>(context, listen: false),
                                  child: RecipeInfo(recipeID: data.item1[index].id,)
                                ),
                              );
                            },
                          ));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          )
          : data.item1.isEmpty && data.item2 == null ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ErrorMessage(message: 'No recipes found for your search.', imgPath: 'assets/icons/empty.png', color: accentColor),
              const SizedBox(height: 10,),
              GestureDetector(
                child: const Text('Try again', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600,),),
                onTap: () {
                  Provider.of<SearchProvider>(context, listen: false).clearSearch();
                },
              )
            ],
          ) :
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ErrorMessage(message: data.item2!.message, imgPath: 'assets/icons/error.png', color: accentColor),
              const SizedBox(height: 10,),
              GestureDetector(
                child: const Text('Try again', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600,),),
                onTap: () {
                  Provider.of<SearchProvider>(context, listen: false).clearSearch();
                },
              )
            ],
          );
        },
      )
    );
  }
}
