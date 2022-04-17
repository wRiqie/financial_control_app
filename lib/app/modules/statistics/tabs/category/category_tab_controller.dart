import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/data/models/category_data.dart';
import 'package:get/get.dart';

class CategoryTabController extends GetxController {
  List<CategoryData> datas = [
    CategoryData(x: 'Home', y: 300, color: DarkColors.homeColor),
    CategoryData(x: 'Food And Drink', y: 50, color: DarkColors.foodDrinkColor),
    CategoryData(x: 'Games And Streaming', y: 80, color: DarkColors.gamesColor),
    CategoryData(x: 'Personal Care', y: 25, color: DarkColors.personalColor),
    CategoryData(x: 'Others', y: 535, color: DarkColors.othersColor),
  ];
}