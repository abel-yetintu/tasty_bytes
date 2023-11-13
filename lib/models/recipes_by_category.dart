class RecipesByCategoryResponse {
    final List<Recipe> recipes;
    final int offset;
    final int number;
    final int totalResults;

    RecipesByCategoryResponse({
        required this.recipes,
        required this.offset,
        required this.number,
        required this.totalResults,
    });

    factory RecipesByCategoryResponse.fromJson(Map<String, dynamic> json) => RecipesByCategoryResponse(
        recipes: List<Recipe>.from(json["results"].map((x) => Recipe.fromJson(x))),
        offset: json["offset"],
        number: json["number"],
        totalResults: json["totalResults"],
    );

    Map<String, dynamic> toJson() => {
        "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
        "offset": offset,
        "number": number,
        "totalResults": totalResults,
    };
}

class Recipe {
    final int id;
    final String title;
    final String image;
    final String imageType;

    Recipe({
        required this.id,
        required this.title,
        required this.image,
        required this.imageType,
    });

    factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imageType: json["imageType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imageType": imageType,
    };
}
