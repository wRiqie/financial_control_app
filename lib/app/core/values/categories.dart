import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:flutter/material.dart';

class Categories {
  static List<Category> baseValues = [
    Category(
      translateName: 'houseBills',
      iconCodePoint: Icons.home.codePoint,
      color: DarkColors.homeColor.value,
    ),
    Category(
      translateName: 'foodAndDrink',
      iconCodePoint: Icons.fastfood.codePoint,
      color: DarkColors.foodDrinkColor.value,
    ),
    Category(
      translateName: 'gamesAndStreaming',
      iconCodePoint: Icons.games.codePoint,
      color: DarkColors.gamesColor.value,
    ),
    Category(
      translateName: 'personalCare',
      iconCodePoint: Icons.person.codePoint,
      color: DarkColors.personalColor.value,
    ),
    Category(
      translateName: 'health',
      iconCodePoint: Icons.healing.codePoint,
      color: DarkColors.healthColor.value,
    ),
    Category(
      translateName: 'studies',
      iconCodePoint: Icons.book.codePoint,
      color: DarkColors.studiesColor.value,
    ),
    Category(
      translateName: 'creditCard',
      iconCodePoint: Icons.credit_card.codePoint,
      color: DarkColors.creditCardColor.value,
    ),
    Category(
      translateName: 'investments',
      iconCodePoint: Icons.show_chart.codePoint,
      color: DarkColors.investmentsColor.value,
    ),
    Category(
      translateName: 'internetPurchases',
      iconCodePoint: Icons.shopping_bag.codePoint,
      color: DarkColors.internetPurchasesColor.value,
    ),
  ];
}
