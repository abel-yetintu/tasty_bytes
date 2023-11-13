enum MealType {
  mainCourse(apiName: 'main course', imgPath: 'assets/images/main_course.jpg'),
  sideDish(apiName: 'side dish', imgPath: 'assets/images/side_dish.jpg'),
  dessert(apiName: 'dessert', imgPath: 'assets/images/dessert.jpg'),
  appetizer(apiName: 'appetizer', imgPath: 'assets/images/appetizer.jpg'),
  salad(apiName: 'salad', imgPath: 'assets/images/salad.jpg'),
  bread(apiName: 'bread', imgPath: 'assets/images/bread.jpg'),
  breakfast(apiName: 'breakfast', imgPath: 'assets/images/breakfast.jpg'),
  soup(apiName: 'soup', imgPath: 'assets/images/soup.jpg'),
  beverage(apiName: 'beverage', imgPath: 'assets/images/beverage.jpg'),
  sauce(apiName: 'sauce', imgPath: 'assets/images/sauce.jpg'),
  marinade(apiName: 'marinade', imgPath: 'assets/images/marinade.jpg'),
  fingerfood(apiName: 'finderfood', imgPath: 'assets/images/fingerfood.jpg'),
  sanck(apiName: 'snack', imgPath: 'assets/images/snack.jpg'),
  drink(apiName: 'drink', imgPath: 'assets/images/drink.jpg');

  final String apiName;
  final String imgPath;
  const MealType({required this.apiName, required this.imgPath});
}
