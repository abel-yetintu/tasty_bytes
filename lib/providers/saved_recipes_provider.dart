import 'package:flutter/material.dart';
import 'package:tasty_bytes/models/recipes_by_category.dart';
import 'package:tasty_bytes/services/database_helper.dart';

class SavedRecipesProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late Future<List<Recipe>> recipes = getAllRecipes();

  String _search = '';
  String get search => _search;
  set search (value) {
    _search = value;
  }
  

  Future<List<Recipe>> getAllRecipes() async {
    return await _databaseHelper.getAllRecipes();
  }

  void getFilteredRecipes(String? name) async {
    final allRecipes = await getAllRecipes();
    if(name != null) {
      recipes = Future.value(allRecipes.where((recipe) => recipe.title.toLowerCase().contains(name)).toList());
      _search = name;
      notifyListeners();
      return;
    }
    recipes = Future.value(allRecipes);
    _search = '';
    notifyListeners();
  }

  Future<int> insertRecipe(Recipe recipe) async {
    final result = await _databaseHelper.insertRecipe(recipe);
    recipes = Future.value(getAllRecipes());
    notifyListeners();
    return result;
  }

  Future<int> deleteRecipe(Recipe recipe) async {
    final result = await _databaseHelper.deleteRecipe(recipe);
    recipes = Future.value(getAllRecipes());
    notifyListeners();
    return result;
  }
}
