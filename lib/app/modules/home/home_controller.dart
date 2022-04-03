import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/enums/bill_status.dart';
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
  final valueCardController = ScrollController();
  num remainingBalance = 0.0;
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

  void openPreferences() async {
    await Get.toNamed(
      Routes.preferences,
      arguments: {
        'month': selectedMonth,
      },
    );
    loadMonth();
  }

  scrollValueCard(double width, int position, {bool back = false}) {
    valueCardController.animateTo(
      back
          ? width * (position > 0 ? position - 1 : position)
          : width * (position + 1),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

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
        arguments: {'categoryId': categoryId, 'selectedMonth': selectedMonth});
    controller.getBills();
  }

  /// loads the month from the database from the selected month
  loadMonth() async {
    var month = await monthRepository
        .getMonthByDate(AppHelpers.formatDateToSave(selectedDate));
    if (month != null) {
      selectedMonth = month;
      calcRemainingBalance();
      return month;
    }
    var monthToAdd = Month(
      date: AppHelpers.formatDateToSave(selectedDate),
      balance: 2100,
    );
    selectedMonth = monthToAdd;
    calcRemainingBalance();
    await monthRepository.saveMonth(monthToAdd);
    return monthToAdd;
  }

  /// Calcule remaining balance of month by monthBalance minus month totalPrice
  calcRemainingBalance() {
    remainingBalance =
        (selectedMonth?.balance ?? 0.0) - (selectedMonth?.totalPrice ?? 0);
    update();
  }

  toogleBillStatus(Bill bill) async {
    if (bill.status != BillStatus.paid.index) {
      bill.status = BillStatus.paid.index;
    } else {
      bill.status = bill.dueDate > DateTime.now().day
          ? BillStatus.pendent.index
          : BillStatus.overdue.index;
    }
    await billRepository.saveBill(bill);
  }

  void deleteBill(Bill bill, CategoryItemController categoryController) async {
    if (selectedMonth != null) {
      var result = await billRepository.deleteBillById(bill.id);
      if (result != 0) {
        // caso nulo fica como o bill.value para resultar 0
        // Evita valores negativos
        selectedMonth!.totalPrice =
            (selectedMonth!.totalPrice ?? bill.value) - bill.value;
        await monthRepository.saveMonth(selectedMonth!);
        await categoryController.getBills();
        await loadMonth();
      }
    }
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    loadMonth();
  }
}
