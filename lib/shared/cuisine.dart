enum Cuisine {
  chinese(apiName: 'Chinese', imgPath: 'assets/images/cuisine/chinese.jpg'),
  french(apiName: 'French', imgPath: 'assets/images/cuisine/french.jpg'),
  american(apiName: 'American', imgPath: 'assets/images/cuisine/american.jpg'),
  japanese(apiName: 'Japanese', imgPath: 'assets/images/cuisine/japanese.jpg'),
  greek(apiName: 'Greek', imgPath: 'assets/images/cuisine/greek.jpg'),
  thai(apiName: 'Thai', imgPath: 'assets/images/cuisine/thai.jpg'),
  spanish(apiName: 'Spanish', imgPath: 'assets/images/cuisine/spanish.jpg'),
  italian(apiName: 'Italian', imgPath: 'assets/images/pasta.jpg'),
  indian(apiName: 'Indian', imgPath: 'assets/images/cuisine/indian.jpg'),
  mexican(apiName: 'Mexican', imgPath: 'assets/images/cuisine/mexican.jpg'),
  korean(apiName: 'Korean', imgPath: 'assets/images/cuisine/korean.jpg'),
  mediterranean(apiName: 'Mediterranean', imgPath: 'assets/images/cuisine/mediterranean.jpg'),
  british(apiName: 'British', imgPath: 'assets/images/cuisine/british.jpg'),
  middleEastern(apiName: 'Middle Eastern', imgPath: 'assets/images/cuisine/middle_eastern.jpg');

  final String apiName;
  final String imgPath;
  const Cuisine({required this.apiName, required this.imgPath});
}
