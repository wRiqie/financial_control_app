import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/core/values/contants.dart';
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
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage(Constants.storageName);
  final uuid = const Uuid();
  final BillRepository billRepository;
  final MonthRepository monthRepository;
  final valueCardController = ScrollController();
  num remainingBalance = 0.0;
  DateTime selectedDate = DateTime.now().add(Duration(days: 30));
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
        arguments: {'categoryId': categoryId, 'categoryIcon': categories[categoryId - 1].icon,'selectedMonth': selectedMonth});
    controller.getBills();
  }

  loadMonth() async {
    var month = await monthRepository
        .getMonthByDate(AppHelpers.formatDateToSave(selectedDate));
    if (month != null) {
      selectedMonth = month;
      calcRemainingBalance();
      return;
    }

    var previousMonthBalance = await loadPreviousMonthBalance();

    var monthToAdd = Month(
      date: AppHelpers.formatDateToSave(selectedDate),
      balance: previousMonthBalance,
    );
    selectedMonth = monthToAdd;

    final copyBills = box.read<bool>(Constants.copyBills);
    await loadAndCopyPreviousMonthBills(copy: copyBills ?? false);

    calcRemainingBalance();
    await monthRepository.saveMonth(selectedMonth!);
    Get.offAllNamed(Routes.dashboard);
    return monthToAdd;
  }

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
        selectedMonth!.totalPrice =
            (selectedMonth!.totalPrice ?? bill.value) - bill.value;
        await monthRepository.saveMonth(selectedMonth!);
        await categoryController.getBills();
        await loadMonth();
      }
    }
    Get.back();
  }

  String get previousMonthDate {
    var month = selectedDate.month - 1 == 0 ? 12 : selectedDate.month - 1;
    var year = month == 12 ? selectedDate.year - 1 : selectedDate.year;
    var date = DateTime(year, month);
    return AppHelpers.formatDateToSave(date);
  }

  Future<num> loadPreviousMonthBalance() async {
    final previousMonth =
        await monthRepository.getMonthByDate(previousMonthDate);

    return previousMonth?.balance ?? 0;
  }

  Future<List<Bill>> loadAndCopyPreviousMonthBills({bool copy = false}) async {
    List<Bill> billsToSave = [];
    num totalPrice = 0.0;
    final previousMonthBills =
        await billRepository.getBillsByDate(previousMonthDate);
    if (!copy) {
      final previousMonthBillsWithPortions = previousMonthBills
          .where((e) => e.portion != null && e.maxPortion != null)
          .toList();
      billsToSave = previousMonthBillsWithPortions;
    } else {
      billsToSave = previousMonthBills;
    }

    billsToSave.removeWhere((e) =>
        e.portion != null &&
        e.maxPortion != null &&
        e.portion! == e.maxPortion!);

    await Future.forEach<Bill>(
      billsToSave,
      (bill) {
        bill.id = uuid.v4();
        bill.date = AppHelpers.formatDateToSave(selectedDate);
        bill.status = bill.dueDate > selectedDate.day
            ? BillStatus.pendent.index
            : BillStatus.overdue.index;

        if (bill.portion != null && bill.maxPortion != null) {
          bill.portion = bill.portion! + 1;
        }
        
        totalPrice += bill.value;
      },
    );

    if(selectedMonth != null) {
      selectedMonth!.totalPrice = totalPrice;
    }

    await billRepository.saveAllBills(billsToSave);
    return billsToSave;
  }

  @override
  void onInit() {
    super.onInit();
    loadMonth();
  }
}
