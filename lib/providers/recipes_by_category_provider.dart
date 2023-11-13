import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/recipes_by_category.dart';
import 'package:tasty_bytes/services/spoonacular_api.dart';
import 'package:tasty_bytes/shared/api_exceptions.dart';
import 'package:tasty_bytes/shared/meal_type.dart';

class RecipesByCategoryProvider extends ChangeNotifier {
  final SpoonacularApi spoonacularApi = SpoonacularApi();
  bool isLoading = true;
  int selectedIndex = 0;

  String _term = '';
  String get term => _term;
  set term (value) {
    _term = value;
  }

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  ApiException? _error;
  ApiException? get error => _error;

  void getRecipesByCategory(MealType mealType, String? term) async {
    try {
      isLoading = true;
      notifyListeners();
      _recipes = await spoonacularApi.getRecipesByCategory(mealType: mealType, term: term);
      _error = null;
      isLoading = false;
      notifyListeners();
    } on ApiException catch (e) {
      isLoading = false;
      _recipes = [];
      _error = e;
      notifyListeners();
    }
  }
}
