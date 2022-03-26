import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:financial_control_app/app/modules/home/widgets/category_item/category_item_controller.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final BillRepository billRepository;
  final MonthRepository monthRepository;
  final monthBalance = 2100.0;
  double remainingBalance = 0.0;
  DateTime selectedDate = DateTime.now();
  Month? selectedMonth;
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

  HomeController(this.monthRepository, this.billRepository);

  swapDate(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 152)),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (date != null) {
      selectedDate = date;
      update();
    }
  }

  addBillToCategory(int categoryId, CategoryItemController controller) async {
    await Get.toNamed(Routes.registerBill,
        arguments: {'categoryId': categoryId});
    controller.getBills();
  }

  selectMonth() async {
    var month = await monthRepository
        .getMonthByDate(AppHelpers.formatDateToSave(selectedDate));
    if (month != null) {
      selectedMonth = month;
      calcRemainingBalance();
      return month;
    }
    var monthToAdd = Month(
      date: AppHelpers.formatDateToSave(selectedDate),
    );
    selectedMonth = monthToAdd;
    calcRemainingBalance();
    await monthRepository.saveMonth(monthToAdd);
    return monthToAdd;
  }

  calcRemainingBalance() {
    remainingBalance = monthBalance - (selectedMonth?.totalPrice ?? 0);
    update();
  }

  openOptionsModal(Bill bill, {required BuildContext context}) {}

  @override
  void onInit() {
    super.onInit();
    selectMonth();
  }
}
