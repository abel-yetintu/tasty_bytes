import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:tasty_bytes/models/complex_recipe_search.dart';
import 'package:tasty_bytes/models/recipe_information.dart';
import 'package:tasty_bytes/models/recipes_by_category.dart';
import 'package:tasty_bytes/shared/api_exceptions.dart';
import 'package:tasty_bytes/shared/cuisine.dart';
import 'package:tasty_bytes/shared/meal_type.dart';
import 'package:http/http.dart' as http;

class SpoonacularApi {
  static const String apiKey = '#';
  // static const String apiKey = '#';
  static const String baseUrl = 'https://api.spoonacular.com/recipes/';
  static const int timeOutDuration = 40;

  Future<List<Recipe>> getRecipesByCategory({required MealType mealType, required String? term}) async {
    if(term != null && term.trim().isNotEmpty) {
      try {
        final Uri uri = Uri.parse('$baseUrl/complexSearch?apiKey=$apiKey&type=${mealType.apiName}&query=$term&sort=random');
        var response = await http.get(uri).timeout(const Duration(seconds: timeOutDuration));
        return _processResponse(response);
      } on SocketException {
        throw FetchDataException(message: 'No internet connection');
      } on FormatException {
        throw BadRequestException(message: 'Error occured while converting format.');
      } on TimeoutException {
        throw ApiNotRespondingException(message: 'Connection problem, please try again.');
      }
    } else {
      try {
        final Uri uri = Uri.parse('$baseUrl/complexSearch?apiKey=$apiKey&type=${mealType.apiName}&sort=random');
        var response = await http.get(uri).timeout(const Duration(seconds: timeOutDuration));
        return _processResponse(response);
      } on SocketException {
        throw FetchDataException(message: 'No internet connection');
      } on FormatException {
        throw BadRequestException(message: 'Error occured while converting format.');
      } on TimeoutException {
        throw ApiNotRespondingException(message: 'Connection problem, please try again.');
      }
    }
  }

  Future<RecipeInformation> getRecipeInformation({required int recipeId}) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/$recipeId/information?apiKey=$apiKey&includeNutrition=true');
      var response = await http.get(uri).timeout(const Duration(seconds: timeOutDuration));
      return _processRecipeInformaionResponse(response);
    } on SocketException {
      throw FetchDataException(message: 'No internet connection');
    } on FormatException {
      throw FetchDataException(message: 'Error occured while converting format.');
    } on TimeoutException {
      throw ApiNotRespondingException(message: 'Api not responding');
    }
  }

  Future<List<ComplexRecipe>> complexRecipeSearch({
      required List<MealType> mealtypes, 
      required List<Cuisine> cuisines,
      required List<String> ingredients,
      required String query
  }) async {

    String url =
    '$baseUrl/complexSearch?apiKey=$apiKey&sort=max-used-ingredients&fillIngredients=true&number=10';

    if(mealtypes.isNotEmpty) {
      url = '$url&type=';
      for (var mealType in mealtypes) {
        url = '$url${mealType.apiName},';
      }
    }
    if(cuisines.isNotEmpty) {
      url = '$url&cuisine=';
      for (var cuisine in cuisines) {
        url = '$url${cuisine.apiName},';
      }
    }
    if(ingredients.isNotEmpty) {
      url = '$url&includeIngredients=';
      for (var ingredient in ingredients) {
        url = '$url$ingredient,';
      }
    }
    if(query.isNotEmpty) {
      url = '$url&query=$query';
    }

    try {
      final Uri uri = Uri.parse(url);
      var response = await http.get(uri).timeout(const Duration(seconds: timeOutDuration));
      return _processComplexRecipeResponse(response);
    } on SocketException {
      throw FetchDataException(message: 'No internet connection');
    } on FormatException {
      throw BadRequestException(message: 'Error occured while converting format.');
    } on TimeoutException {
      throw ApiNotRespondingException(message: 'Connection problem, please try again.');
    }
  }

  List<Recipe> _processResponse (Response response) {
    switch (response.statusCode) {
      case 200:
        return RecipesByCategoryResponse.fromJson(jsonDecode(response.body)).recipes;
      case 400:
        throw BadRequestException(message: 'Your request is invalid');
      case 401:
        throw UnAuthorizedException(message: 'Unauthorized, attempt failed.');
      case 402:
        throw UnAuthorizedException(message: 'Daily api quota has been reached. try again tomorrow');
      case 404:
        throw BadRequestException(message: 'No recipes found.');
      default:
        throw FetchDataException(message: 'Service Unavailable. Error occured with code: ${response.statusCode}');
    }
  }

  RecipeInformation _processRecipeInformaionResponse (Response response) {
    switch (response.statusCode) {
      case 200:
        return RecipeInformation.fromJson(jsonDecode(response.body));
      case 400:
        throw BadRequestException(message: 'Your request is invalid');
      case 401:
        throw UnAuthorizedException(message: 'Unauthorized, attempt failed.');
      case 402:
        throw UnAuthorizedException(message: 'Daily api quota has been reached. try again tomorrow');
      case 404:
        throw BadRequestException(message: 'No recipes found.');
      default:
        throw FetchDataException(message: 'Service Unavailable. Error occured with code: ${response.statusCode}');
    }
  }

  List<ComplexRecipe> _processComplexRecipeResponse (Response response) {
    switch (response.statusCode) {
      case 200:
        return ComplexRecipeSearch.fromJson(jsonDecode(response.body)).results;
      case 400:
        throw BadRequestException(message: 'Your request is invalid');
      case 401:
        throw UnAuthorizedException(message: 'Unauthorized, attempt failed.');
      case 402:
        throw UnAuthorizedException(message: 'Daily api quota has been reached. try again tomorrow');
      case 404:
        throw BadRequestException(message: 'No recipes found.');
      default:
        throw FetchDataException(message: 'Service Unavailable. Error occured with code: ${response.statusCode}');
    }
  }
}

 
