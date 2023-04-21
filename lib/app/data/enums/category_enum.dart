import '../../core/theme/dark/dark_colors.dart';
import 'package:flutter/material.dart';

enum ECategory {
  houseBills,
  foodAndDrink,
  gamesAndStreaming,
  personalCare,
  health,
  studies,
  creditCard,
  investments,
  internetPurchases,
  others,
}

extension CategoryExtension on ECategory {
  static final _categories = [
    {
      'id': 0,
      'category': ECategory.houseBills,
      'icon': Icons.home,
      'color': DarkColors.homeColor,
    },
    {
      'id': 1,
      'category': ECategory.foodAndDrink,
      'icon': Icons.fastfood,
      'color': DarkColors.foodDrinkColor,
    },
    {
      'id': 2,
      'category': ECategory.gamesAndStreaming,
      'icon': Icons.games,
      'color': DarkColors.gamesColor,
    },
    {
      'id': 3,
      'category': ECategory.personalCare,
      'icon': Icons.person,
      'color': DarkColors.personalColor,
    },
    {
      'id': 4,
      'category': ECategory.others,
      'icon': Icons.add,
      'color': DarkColors.othersColor,
    },
    {
      'id': 5,
      'category': ECategory.health,
      'icon': Icons.healing,
      'color': DarkColors.healthColor,
    },
    {
      'id': 6,
      'category': ECategory.studies,
      'icon': Icons.book,
      'color': DarkColors.studiesColor,
    },
    {
      'id': 7,
      'category': ECategory.creditCard,
      'icon': Icons.credit_card,
      'color': DarkColors.creditCardColor,
    },
    {
      'id': 8,
      'category': ECategory.investments,
      'icon': Icons.show_chart,
      'color': DarkColors.investmentsColor,
    },
    {
      'id': 9,
      'category': ECategory.internetPurchases,
      'icon': Icons.shopping_bag,
      'color': DarkColors.internetPurchasesColor,
    },
  ];

  int get id =>
      _categories.firstWhere((e) => e['category'] == this)['id'] as int;

  static ECategory getById(int id) =>
      _categories.firstWhere((e) => e['id'] == id)['category'] as ECategory;

  static IconData icon(int id) =>
      _categories.firstWhere((e) => e['id'] == id)['icon'] as IconData;

  static Color color(int id) =>
      _categories.firstWhere((e) => e['id'] == id)['color'] as Color;
}
