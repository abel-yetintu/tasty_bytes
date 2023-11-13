import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bytes/models/recipes_by_category.dart';
import 'package:tasty_bytes/providers/recipe_information_provider.dart';
import 'package:tasty_bytes/providers/saved_recipes_provider.dart';
import 'package:tasty_bytes/shared/color_palette.dart';
import 'package:tasty_bytes/shared/error_message.dart';
import 'package:tasty_bytes/widgets/tabs/description.dart';
import 'package:tasty_bytes/widgets/tabs/direction.dart';

class RecipeInfo extends StatefulWidget {
  final int recipeID;
  const RecipeInfo({super.key, required this.recipeID});

  @override
  State<RecipeInfo> createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<RecipeInformationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getRecipeInformation(widget.recipeID);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RecipeInformationProvider>(context);
    return provider.isLoading ? 
      Scaffold(
        backgroundColor: colorWhite,
        body: loadingWidget(context, 70),
      ) 
      : provider.recipeInformation != null ?
      DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: colorWhite,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: secondaryColor,
                      radius: 16,
                      child: Icon(Icons.arrow_back, size: 24, color: colorBlack,),
                    ),
                  ),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: secondaryColor,
                      radius: 16,
                      child: SizedBox(height: 24, child: Image.asset('assets/icons/bookmark.png', fit: BoxFit.cover,),)
                    ),
                    onTap: () async {
                      var recipe = provider.recipeInformation!;
                      var result = await Provider.of<SavedRecipesProvider>(context, listen: false).insertRecipe(
                        Recipe(id: recipe.id, title: recipe.title, image: recipe.image, imageType: recipe.imageType)
                      );
                      if(result != -1) {
                        // show toast
                        Fluttertoast.showToast(
                          msg: 'Recipe saved.',
                          backgroundColor: primaryColor,
                          textColor: colorBlack,
                          toastLength: Toast.LENGTH_SHORT
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(provider.recipeInformation!.image, fit: BoxFit.cover,)
              ),
              const Padding(
                padding:  EdgeInsets.only(left: 24, right: 24),
                child: TabBar(
                  labelColor: primaryColor,
                  labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  tabs: [
                    Tab(text: 'Description',),
                    Tab(text: 'Direction',),
                  ]
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Description(recipeInformation: provider.recipeInformation!,),
                    Direction(recipeInformation: provider.recipeInformation!,),
                  ],
                ),
              )
            ],
          ),
        ),
      ) 
    : errorWidget(provider.error!.message);
  }

  Widget errorWidget(String message) {
    //Navigator.pop(context, 'error');
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: ErrorMessage(
          message: message, 
          imgPath: message == 'No internet connection' ? 'assets/icons/no_connection.png' : 'assets/icons/error.png', 
          color: accentColor
        )
      )
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