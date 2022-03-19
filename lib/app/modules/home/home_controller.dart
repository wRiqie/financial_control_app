import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final remainingBalance = 645.30;
  List<Category> categories = [
    Category(id: 1, color: DarkColors.homeColor, icon: Icons.home,),
    Category(id: 2, color: DarkColors.foodDrinkColor, icon: Icons.fastfood,),
    Category(id: 3, color: DarkColors.gamesColor, icon: Icons.games,),
    Category(id: 4, color: DarkColors.personalColor, icon: Icons.person,),
    Category(id: 5, color: DarkColors.othersColor, icon: Icons.dashboard,),
  ];

  
}
