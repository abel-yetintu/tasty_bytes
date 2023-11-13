
class ComplexRecipeSearch {
    final List<ComplexRecipe> results;
    final int offset;
    final int number;
    final int totalResults;

    ComplexRecipeSearch({
        required this.results,
        required this.offset,
        required this.number,
        required this.totalResults,
    });

    factory ComplexRecipeSearch.fromJson(Map<String, dynamic> json) => ComplexRecipeSearch(
        results: List<ComplexRecipe>.from(json["results"].map((x) => ComplexRecipe.fromJson(x))),
        offset: json["offset"],
        number: json["number"],
        totalResults: json["totalResults"],
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "offset": offset,
        "number": number,
        "totalResults": totalResults,
    };
}

class ComplexRecipe {
    final int id;
    final int usedIngredientCount;
    final int missedIngredientCount;
    final int likes;
    final List<ComplexIngredient> missedIngredients;
    final List<ComplexIngredient> usedIngredients;
    final List<dynamic> unusedIngredients;
    final String title;
    final String image;
    final String imageType;

    ComplexRecipe({
        required this.id,
        required this.usedIngredientCount,
        required this.missedIngredientCount,
        required this.likes,
        required this.missedIngredients,
        required this.usedIngredients,
        required this.unusedIngredients,
        required this.title,
        required this.image,
        required this.imageType,
    });

    factory ComplexRecipe.fromJson(Map<String, dynamic> json) => ComplexRecipe(
        id: json["id"],
        usedIngredientCount: json["usedIngredientCount"],
        missedIngredientCount: json["missedIngredientCount"],
        likes: json["likes"],
        missedIngredients: List<ComplexIngredient>.from(json["missedIngredients"].map((x) => ComplexIngredient.fromJson(x))),
        usedIngredients: List<ComplexIngredient>.from(json["usedIngredients"].map((x) => ComplexIngredient.fromJson(x))),
        unusedIngredients: List<dynamic>.from(json["unusedIngredients"].map((x) => x)),
        title: json["title"],
        image: json["image"],
        imageType: json["imageType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "usedIngredientCount": usedIngredientCount,
        "missedIngredientCount": missedIngredientCount,
        "likes": likes,
        "missedIngredients": List<dynamic>.from(missedIngredients.map((x) => x.toJson())),
        "usedIngredients": List<dynamic>.from(usedIngredients.map((x) => x.toJson())),
        "unusedIngredients": List<dynamic>.from(unusedIngredients.map((x) => x)),
        "title": title,
        "image": image,
        "imageType": imageType,
    };
}

class ComplexIngredient {
    final int id;
    final double amount;
    final String unit;
    final String unitLong;
    final String unitShort;
    final String name;
    final String original;
    final String originalName;
    final String image;

    ComplexIngredient({
        required this.id,
        required this.amount,
        required this.unit,
        required this.unitLong,
        required this.unitShort,
        required this.name,
        required this.original,
        required this.originalName,
        required this.image,
    });

    factory ComplexIngredient.fromJson(Map<String, dynamic> json) => ComplexIngredient(
        id: json["id"],
        amount: json["amount"]?.toDouble(),
        unit: json["unit"],
        unitLong: json["unitLong"],
        unitShort: json["unitShort"],
        name: json["name"],
        original: json["original"],
        originalName: json["originalName"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "unit": unit,
        "unitLong": unitLong,
        "unitShort": unitShort,
        "name": name,
        "original": original,
        "originalName": originalName,
        "image": image,
    };
}