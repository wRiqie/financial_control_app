enum ECategory {
  home,
  foodAndDrinks,
  games,
  person,
  dashboard,
  others,
}

extension CategoryExtension on ECategory {
  static final _categories = [
    {'id': 0, 'category': ECategory.home},
    {'id': 1, 'category': ECategory.foodAndDrinks},
    {'id': 2, 'category': ECategory.games},
    {'id': 3, 'category': ECategory.person},
    {'id': 4, 'category': ECategory.dashboard},
    {'id': 5, 'category': ECategory.others},
  ];

  static ECategory getById(int id) {
    return _categories.firstWhere((e) => e['id'] == id)['category'] as ECategory;
  }
}
