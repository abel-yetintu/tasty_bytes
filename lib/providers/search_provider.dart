import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/complex_recipe_search.dart';
import 'package:tasty_bytes/services/spoonacular_api.dart';
import 'package:tasty_bytes/shared/api_exceptions.dart';
import 'package:tasty_bytes/shared/cuisine.dart';
import 'package:tasty_bytes/shared/meal_type.dart';

class SearchProvider extends ChangeNotifier {
  final SpoonacularApi _spoonacularApi = SpoonacularApi();

  final List<String> _ingredients = [];
  List<String> get ingredients => _ingredients;

  final List<Cuisine> _cuisines = [];
  List<Cuisine> get cuisines => _cuisines;

  final List<MealType> _mealType = [];
  List<MealType> get mealType => _mealType;

  String _query = "";
  String get query => _query;
  set query(value) {
    _query = value;
  }

  List<ComplexRecipe> _recipes = [];
  List<ComplexRecipe> get recipes => _recipes;

  bool isLoading = false;
  bool showSearchFilters = true;

  ApiException? _error;
  ApiException? get error => _error;

  void complexRecipeSearch() async {
    try {
      isLoading = true;
      showSearchFilters = false;
      notifyListeners();
      _recipes = await _spoonacularApi.complexRecipeSearch(mealtypes: _mealType, cuisines: _cuisines, ingredients: _ingredients, query: query);
      _error = null;
      isLoading = false;
      notifyListeners();
    } on ApiException catch(e) {
      isLoading = false;
      _recipes = [];
      _error = e;
      notifyListeners();
    }
  }

  void clearSearch() {
    _recipes.clear();
    showSearchFilters = true;
    _error = null;
    _query = '';
    _cuisines.clear();
    _ingredients.clear();
    _mealType.clear();
    notifyListeners();
  }

  String getStringCusine() {
    var string = '';
    if(_cuisines.isNotEmpty) {
      for (var cuisine in _cuisines) {
        if(_cuisines.last == cuisine) {
          string = '$string${cuisine.apiName}';
        } else {
           string = '$string${cuisine.apiName}, ';
        }
      }
      return string;
    }
    return string;
  }

  String getStringIngredients() {
    var string = '';
    if(_ingredients.isNotEmpty) {
      for (var ingredient in _ingredients) { 
        if(_ingredients.last == ingredient){
          string = '$string$ingredient';
        } else {
          string = '$string$ingredient, ';
        }
      }
      return string;
    }
    return string;
  }

  String getStringMealTypes() {
    var string = '';
    if(_mealType.isNotEmpty) {
      for (var meal in _mealType) {
        if(_mealType.last == meal) {
          string = '$string${meal.apiName}';
        } else {
          string = '$string${meal.apiName}, ';
        }
      }
      return string;
    }
    return string;
  }

  void addIngredient(String ingredient) {
    _ingredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(String ingredient) {
    if (_ingredients.contains(ingredient)) {
      _ingredients.remove(ingredient);
      notifyListeners();
    }
  }

  void clearIngredients() {
    _ingredients.clear();
    notifyListeners();
  }

  void addCuisine(Cuisine cuisine) {
    _cuisines.add(cuisine);
    notifyListeners();
  }

  void removeCuisine(Cuisine cuisine) {
    if (_cuisines.contains(cuisine)) {
      _cuisines.remove(cuisine);
      notifyListeners();
    }
  }

  void clearCuisines() {
    _cuisines.clear();
    notifyListeners();
  }

  void addMealType(MealType mealType) {
    _mealType.add(mealType);
    notifyListeners();
  }

  void removeMealType(MealType mealType) {
    if (_mealType.contains(mealType)) {
      _mealType.remove(mealType);
      notifyListeners();
    }
  }

  void clearMealType() {
    _mealType.clear();
    notifyListeners();
  }
}
