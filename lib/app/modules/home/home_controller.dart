import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final remainingBalance = 645.30;
  DateTime selectedDate = DateTime.now();
  List<Category> categories = [
    Category(
      id: 1,
      color: DarkColors.homeColor,
      icon: Icons.home,
    ),
    Category(
      id: 2,
      color: DarkColors.foodDrinkColor,
      icon: Icons.fastfood,
    ),
    Category(
      id: 3,
      color: DarkColors.gamesColor,
      icon: Icons.games,
    ),
    Category(
      id: 4,
      color: DarkColors.personalColor,
      icon: Icons.person,
    ),
    Category(
      id: 5,
      color: DarkColors.othersColor,
      icon: Icons.dashboard,
    ),
  ];

  swapDate(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 152)),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if(date != null) {
      selectedDate = date;
      update();
    }
  }

  addBill(int categoryId) async {
    Get.toNamed(Routes.registerBill, arguments: {'categoryId': categoryId});
  }
}
