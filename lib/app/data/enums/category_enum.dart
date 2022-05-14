import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:flutter/material.dart';

enum ECategory {
  home,
  foodAndDrinks,
  games,
  person,
  others,
}

extension CategoryExtension on ECategory {
  static final _categories = [
    {
      'id': 0,
      'name': 'houseBills',
      'category': ECategory.home,
      'icon': Icons.home,
      'color': DarkColors.homeColor,
    },
    {
      'id': 1,
      'name': 'foodAndDrink',
      'category': ECategory.foodAndDrinks,
      'icon': Icons.fastfood,
      'color': DarkColors.foodDrinkColor,
    },
    {
      'id': 2,
      'name': 'gamesAndStreaming',
      'category': ECategory.games,
      'icon': Icons.games,
      'color': DarkColors.gamesColor,
    },
    {
      'id': 3,
      'name': 'personalCare',
      'category': ECategory.person,
      'icon': Icons.person,
      'color': DarkColors.personalColor,
    },
    {
      'id': 4,
      'name': 'others',
      'category': ECategory.others,
      'icon': Icons.add,
      'color': DarkColors.othersColor,
    },
  ];

  int get id =>
      _categories.firstWhere((e) => e['category'] == this)['id'] as int;
  
  String get name =>
      _categories.firstWhere((e) => e['category'] == this)['name'] as String;

  static ECategory getById(int id) =>
      _categories.firstWhere((e) => e['id'] == id)['category'] as ECategory;

  static IconData icon(int id) =>
      _categories.firstWhere((e) => e['id'] == id)['icon'] as IconData;

  static Color color(int id) =>
      _categories.firstWhere((e) => e['id'] == id)['color'] as Color;
}
