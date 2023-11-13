import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/recipe_information.dart';
import 'package:tasty_bytes/services/spoonacular_api.dart';
import 'package:tasty_bytes/shared/api_exceptions.dart';

class RecipeInformationProvider extends ChangeNotifier {
  final SpoonacularApi spoonacularApi = SpoonacularApi();
  bool isLoading = true;

  ApiException? _error;
  ApiException? get error => _error;

  RecipeInformation? _recipeInformation;
  RecipeInformation? get recipeInformation => _recipeInformation;

  void getRecipeInformation(int recipeId) async {
    try {
      isLoading = true;
      notifyListeners();
      _recipeInformation = await spoonacularApi.getRecipeInformation(recipeId: recipeId);
      _error = null;
      isLoading = false;
      notifyListeners();
    } on ApiException catch (e) {
      isLoading = false;
      _recipeInformation = null;
      _error = e;
      notifyListeners();
    }
  }
}
