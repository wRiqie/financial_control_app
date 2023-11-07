import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/data/models/category_model.dart';
import 'package:flutter/material.dart';

class Categories {
  static List<CategoryModel> baseValues = [
    CategoryModel(
      translateName: 'houseBills',
      iconCodePoint: Icons.home.codePoint,
      color: DarkColors.homeColor.value,
    ),
    CategoryModel(
      translateName: 'foodAndDrink',
      iconCodePoint: Icons.fastfood.codePoint,
      color: DarkColors.foodDrinkColor.value,
    ),
    CategoryModel(
      translateName: 'gamesAndStreaming',
      iconCodePoint: Icons.games.codePoint,
      color: DarkColors.gamesColor.value,
    ),
    CategoryModel(
      translateName: 'personalCare',
      iconCodePoint: Icons.person.codePoint,
      color: DarkColors.personalColor.value,
    ),
    CategoryModel(
      translateName: 'health',
      iconCodePoint: Icons.healing.codePoint,
      color: DarkColors.healthColor.value,
    ),
    CategoryModel(
      translateName: 'studies',
      iconCodePoint: Icons.book.codePoint,
      color: DarkColors.studiesColor.value,
    ),
    CategoryModel(
      translateName: 'creditCard',
      iconCodePoint: Icons.credit_card.codePoint,
      color: DarkColors.creditCardColor.value,
    ),
    CategoryModel(
      translateName: 'investments',
      iconCodePoint: Icons.show_chart.codePoint,
      color: DarkColors.investmentsColor.value,
    ),
    CategoryModel(
      translateName: 'internetPurchases',
      iconCodePoint: Icons.shopping_bag.codePoint,
      color: DarkColors.internetPurchasesColor.value,
    ),
  ];
}
