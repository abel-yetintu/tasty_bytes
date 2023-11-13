import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_bytes/pages/home_page.dart';
import 'package:tasty_bytes/providers/recipes_by_category_provider.dart';
import 'package:tasty_bytes/providers/saved_recipes_provider.dart';
import 'package:tasty_bytes/providers/search_provider.dart';
import 'package:tasty_bytes/shared/color_palette.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value) => runApp(const TastyBytes()));
}

class TastyBytes extends StatelessWidget {
  const TastyBytes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSwatch(accentColor: accentColor)),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
            create: (context) => RecipesByCategoryProvider()),
        ChangeNotifierProvider(create: (context) => SavedRecipesProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider())
      ], child: const HomePage()),
    );
  }
}
