import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasty_bytes/models/recipes_by_category.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'recipes.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabse);
  }

  void _createDatabse(Database db, int version) async {
    String sql = '''
CREATE TABLE ${Tables.recipesTable}(
  ${RecipeFields.id} INTEGER PRIMARY KEY,
  ${RecipeFields.title} TEXT NOT NULL,
  ${RecipeFields.image} TEXT NOT NULL,
  ${RecipeFields.imageType} TEXT NOT NULL
  )
''';
    await db.execute(sql);
  }

  // CRUD operations

  Future<List<Recipe>> getAllRecipes() async {
    final database = await this.database;
    final result = await database.query(Tables.recipesTable);
    return result.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<int> insertRecipe(Recipe recipe) async {
    final database = await this.database;
    return await database.insert(Tables.recipesTable, recipe.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteRecipe(Recipe recipe) async {
    final database = await this.database;
    return await database.delete(
      Tables.recipesTable,
      where: '${RecipeFields.id} = ?',
      whereArgs: [recipe.id]
    );
  }
}

class Tables {
  static const String recipesTable = 'recipes';
}

class RecipeFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String image = 'image';
  static const String imageType = 'imageType';
}
