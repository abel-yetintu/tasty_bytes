

class RecipeInformation {
    final int preparationMinutes;
    final int cookingMinutes;
    final String sourceName;
    final double pricePerServing;
    final List<ExtendedIngredient> extendedIngredients;
    final int id;
    final String title;
    final int readyInMinutes;
    final int servings;
    final String sourceUrl;
    final String image;
    final String imageType;
    final String summary;
    final Nutrition nutrition;
    final List<AnalyzedInstruction> analyzedInstructions;

    RecipeInformation({
        required this.preparationMinutes,
        required this.cookingMinutes,
        required this.sourceName,
        required this.pricePerServing,
        required this.extendedIngredients,
        required this.id,
        required this.title,
        required this.readyInMinutes,
        required this.servings,
        required this.sourceUrl,
        required this.image,
        required this.imageType,
        required this.summary,
        required this.nutrition,
        required this.analyzedInstructions,
    });

    factory RecipeInformation.fromJson(Map<String, dynamic> json) => RecipeInformation(
        preparationMinutes: json["preparationMinutes"],
        cookingMinutes: json["cookingMinutes"],
        sourceName: json["sourceName"],
        pricePerServing: json["pricePerServing"]?.toDouble(),
        extendedIngredients: List<ExtendedIngredient>.from(json["extendedIngredients"].map((x) => ExtendedIngredient.fromJson(x))),
        id: json["id"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
        image: json["image"],
        imageType: json["imageType"],
        nutrition: Nutrition.fromJson(json["nutrition"]),
        summary: json["summary"],
        analyzedInstructions: List<AnalyzedInstruction>.from(json["analyzedInstructions"].map((x) => AnalyzedInstruction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "preparationMinutes": preparationMinutes,
        "cookingMinutes": cookingMinutes,
        "sourceName": sourceName,
        "pricePerServing": pricePerServing,
        "extendedIngredients": List<dynamic>.from(extendedIngredients.map((x) => x.toJson())),
        "id": id,
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
        "image": image,
        "imageType": imageType,
        "summary": summary,
        "analyzedInstructions": List<dynamic>.from(analyzedInstructions.map((x) => x.toJson())),
    };
}

class Nutrition {
    final List<Nutrient> nutrients;

    Nutrition({
        required this.nutrients,
    });

    factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
        nutrients: List<Nutrient>.from(json["nutrients"].map((x) => Nutrient.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nutrients": List<dynamic>.from(nutrients.map((x) => x.toJson())),
    };
}

class Nutrient {
    final String name;
    final double amount;
    final String unit;
    final double percentOfDailyNeeds;

    Nutrient({
        required this.name,
        required this.amount,
        required this.unit,
        required this.percentOfDailyNeeds,
    });

    factory Nutrient.fromJson(Map<String, dynamic> json) => Nutrient(
        name: json["name"],
        amount: json["amount"]?.toDouble(),
        unit: json["unit"]!,
        percentOfDailyNeeds: json["percentOfDailyNeeds"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "unit": unit,
        "percentOfDailyNeeds": percentOfDailyNeeds,
    };
}

class AnalyzedInstruction {
    final String name;
    final List<Step> steps;

    AnalyzedInstruction({
        required this.name,
        required this.steps,
    });

    factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) => AnalyzedInstruction(
        name: json["name"],
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
    };
}

class Step {
    final int number;
    final String step;
    final List<Ent> ingredients;
    final List<Ent> equipment;
    final Length? length;

    Step({
        required this.number,
        required this.step,
        required this.ingredients,
        required this.equipment,
        this.length,
    });

    factory Step.fromJson(Map<String, dynamic> json) => Step(
        number: json["number"],
        step: json["step"],
        ingredients: List<Ent>.from(json["ingredients"].map((x) => Ent.fromJson(x))),
        equipment: List<Ent>.from(json["equipment"].map((x) => Ent.fromJson(x))),
        length: json["length"] == null ? null : Length.fromJson(json["length"]),
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "step": step,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "equipment": List<dynamic>.from(equipment.map((x) => x.toJson())),
        "length": length?.toJson(),
    };
}

class Ent {
    final int id;
    final String name;
    final String localizedName;
    final String image;

    Ent({
        required this.id,
        required this.name,
        required this.localizedName,
        required this.image,
    });

    factory Ent.fromJson(Map<String, dynamic> json) => Ent(
        id: json["id"],
        name: json["name"],
        localizedName: json["localizedName"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "localizedName": localizedName,
        "image": image,
    };
}

class Length {
    final int number;
    final String unit;

    Length({
        required this.number,
        required this.unit,
    });

    factory Length.fromJson(Map<String, dynamic> json) => Length(
        number: json["number"],
        unit: json["unit"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "unit": unit,
    };
}

class ExtendedIngredient {
    final int id;
    final String image;
    final String name;
    final String nameClean;
    final String original;
    final String originalName;
    final double amount;
    final String unit;
    final Measures measures;

    ExtendedIngredient({
        required this.id,
        required this.image,
        required this.name,
        required this.nameClean,
        required this.original,
        required this.originalName,
        required this.amount,
        required this.unit,
        required this.measures,
    });

    factory ExtendedIngredient.fromJson(Map<String, dynamic> json) => ExtendedIngredient(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        nameClean: json["nameClean"],
        original: json["original"],
        originalName: json["originalName"],
        amount: json["amount"],
        unit: json["unit"],
        measures: Measures.fromJson(json["measures"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "nameClean": nameClean,
        "original": original,
        "originalName": originalName,
        "amount": amount,
        "unit": unit,
        "measures": measures.toJson(),
    };
}

class Measures {
    final Metric us;
    final Metric metric;

    Measures({
        required this.us,
        required this.metric,
    });

    factory Measures.fromJson(Map<String, dynamic> json) => Measures(
        us: Metric.fromJson(json["us"]),
        metric: Metric.fromJson(json["metric"]),
    );

    Map<String, dynamic> toJson() => {
        "us": us.toJson(),
        "metric": metric.toJson(),
    };
}

class Metric {
    final double amount;
    final String unitShort;
    final String unitLong;

    Metric({
        required this.amount,
        required this.unitShort,
        required this.unitLong,
    });

    factory Metric.fromJson(Map<String, dynamic> json) => Metric(
        amount: json["amount"],
        unitShort: json["unitShort"],
        unitLong: json["unitLong"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "unitShort": unitShort,
        "unitLong": unitLong,
    };
}
