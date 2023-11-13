import 'package:flutter/material.dart';
import 'package:tasty_bytes/shared/color_palette.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24, top: 10,),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tasty Bytes',
                      style: TextStyle(color: accentColor, fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Description',
                  style: TextStyle(color: accentColor, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    ' This app is designed to make cooking and meal planning easier and more enjoyable for users. With a user-friendly interface and a wide selection of recipes, this app is perfect for anyone looking to expand their culinary skills or find new meal ideas.',
                    style: TextStyle(color: colorBlack, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Features',
                  style: TextStyle(color: accentColor, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '\u2022 Recipe Collection: The app offers a vast collection of recipes from different cuisines and meal types.',
                    style: TextStyle(color: colorBlack, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 4,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '\u2022 Search: The app includes a powerful search feature that allows users to search for recipes by ingredients, recipe name, cuisines, and meal types.',
                    style: TextStyle(color: colorBlack, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 4,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '\u2022 Recipe Details: Users can view detailed information about each recipe, including cooking time, calories, ingredients, serving size, and step-by-step instructions.',
                    style: TextStyle(color: colorBlack, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 4,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '\u2022 Favorites: Users can save their favorite recipes to a dedicated section within the app, making it easy to find and access them later.',
                    style: TextStyle(color: colorBlack, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 4,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '\u2022 Step-by-Step Instructions: The app provides step-by-step instructions and guides users through the cooking process, making it easier for beginners to follow along.',
                    style: TextStyle(color: colorBlack, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Developed By',
                  style: TextStyle(color: accentColor, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    'Abel Yetintu',
                    style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Powered By',
                  style: TextStyle(color: accentColor, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset('assets/images/spoonacular_logo.jpg'),
                      ),
                      const SizedBox(width: 8,),
                      const Text(
                        'spoonacular API',
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}