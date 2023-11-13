enum Diets {
  glutenFree(apiName: 'Gluten Free'),
  n(apiName: 'Gluten Free');

  final String apiName;
  const Diets({required this.apiName});
}
