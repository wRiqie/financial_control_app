import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/core/values/constants.dart';
import 'package:financial_control_app/app/data/enums/bill_status_enum.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
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
  final CategoryRepository categoryRepository;
  final MonthRepository monthRepository;
  final BillRepository billRepository;
  final valueCardController = ScrollController();
  num remainingBalance = 0.0;
  DateTime selectedDate = DateTime.now();
  Month? selectedMonth;
  List<Month> availableMonths = [];
  List<Category> categories = [];
  List<Bill> selectedBills = [];
  bool isValuesVisible = false;

  HomeController(
      this.categoryRepository, this.monthRepository, this.billRepository);

  Future<void> openPreferences() async {
    await Get.toNamed(
      Routes.preferences,
      arguments: {
        'month': selectedMonth,
      },
    );
    loadMonth();
  }

  Future<void> toggleValuesVisibility() async {
    isValuesVisible = !isValuesVisible;
    await box.write(Constants.isValuesVisible, isValuesVisible);
    update();
  }

  void scrollValueCard(double width, int position, {bool back = false}) {
    valueCardController.animateTo(
      back
          ? width * (position > 0 ? position - 1 : position)
          : width * (position + 1),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  Future<void> swapDate() async {
      // selectedDate = newDate;
      // await reload();

      update();
  }

  Future<void> reload() async {
    await loadCategories();
    await loadMonth();
  }

  Future<void> addBillToCategory(
      int categoryId, CategoryItemController controller) async {
    await Get.toNamed(Routes.registerBill,
        arguments: {'categoryId': categoryId, 'selectedMonth': selectedMonth});
    controller.getBills();
  }

  Future<void> loadCategories() async {
    categories.clear();
    update();
    await Future.delayed(const Duration(milliseconds: 200));
    categories = await categoryRepository.getSelectedCategories();
    update();
  }

  Future<void> loadMonthsList() async {
    availableMonths = await monthRepository.getMonths();
    update();
  }

  Future<Month?> loadMonth() async {
    var month = await monthRepository
        .getMonthByDate(AppHelpers.formatDateToSave(selectedDate));
    if (month != null) {
      selectedMonth = month;
      calcRemainingBalance();
      return null;
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

  void calcRemainingBalance() {
    remainingBalance =
        (selectedMonth?.balance ?? 0.0) - (selectedMonth?.totalPrice ?? 0);
    update();
  }

  Future<void> toggleBillStatus(Bill bill) async {
    if (bill.status != EBillStatus.paid.id) {
      bill.status = EBillStatus.paid.id;
    } else {
      bill.status = bill.dueDate > DateTime.now().day
          ? EBillStatus.pendent.id
          : EBillStatus.overdue.id;
    }
    await billRepository.saveBill(bill);
  }

  void deleteBill(Bill bill, CategoryItemController categoryController) async {
    if (selectedMonth != null) {
      var result = await billRepository.deleteBillById(bill.id);
      if (result != 0) {
        await categoryController.getBills();
        await loadMonth();
      }
    }
    Get.back();
  }

  void deleteBills() async {
    if (selectedBills.isNotEmpty) {
      await billRepository.deleteBillsByIds(selectedBills);
      clearSelectedBills();
      await reload();
    }
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
            ? EBillStatus.pendent.id
            : EBillStatus.overdue.id;

        if (bill.portion != null && bill.maxPortion != null) {
          bill.portion = bill.portion! + 1;
        }

        totalPrice += bill.value;
      },
    );

    if (selectedMonth != null) {
      selectedMonth!.totalPrice = totalPrice;
    }

    await billRepository.saveAllBills(billsToSave);
    return billsToSave;
  }

  void toggleSelectedBill(Bill bill) {
    bool selected = selectedBills.contains(bill);
    if (selected) {
      selectedBills.remove(bill);
    } else {
      selectedBills.add(bill);
    }
    update();
  }

  void clearSelectedBills() {
    selectedBills.clear();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    isValuesVisible = box.read(Constants.isValuesVisible) ?? true;
    await loadCategories();
    await loadMonthsList();
    await loadMonth();
  }
}
