import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/helpers.dart';
import '../../core/values/constants.dart';
import '../../data/enums/bill_status_enum.dart';
import '../../data/models/bill.dart';
import '../../data/models/category.dart';
import '../../data/models/month.dart';
import '../../data/repository/bill_repository.dart';
import '../../data/repository/category_repository.dart';
import '../../data/repository/month_repository.dart';
import '../../routes/pages.dart';
import 'widgets/category_item/category_item_controller.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage(Constants.storageName);
  final uuid = const Uuid();
  final CategoryRepository categoryRepository;
  final MonthRepository monthRepository;
  final BillRepository billRepository;
  final valueCardController = ScrollController();
  num remainingBalance = 0.0;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 50));
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

  Future<void> loadMonth() async {
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

    final previousDate = await previousMonthDate();
    if (previousDate != null) {
      final copyBills = box.read<bool>(Constants.copyBills);
      await loadAndCopyPreviousMonthBills(previousDate, copy: copyBills ?? false);
    }

    calcRemainingBalance();
    await monthRepository.saveMonth(selectedMonth!);
    // Get.offAllNamed(Routes.dashboard);
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
      bill.status = bill.dueDate >= DateTime.now().day
          ? EBillStatus.pendent.id
          : EBillStatus.overdue.id;
    }
    await billRepository.saveBill(bill);
    await loadMonth();
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

  Future<String?> previousMonthDate() {
    return monthRepository.getLastMonthDate();
  }

  Future<num> loadPreviousMonthBalance() async {
    final previousDate = await previousMonthDate();
    if (previousDate != null) {
      final previousMonth = await monthRepository.getMonthByDate(previousDate);
      return previousMonth?.balance ?? 0;
    }

    return 0;
  }

  Future<List<Bill>> loadAndCopyPreviousMonthBills(String previousDate, {bool copy = false}) async {
    List<Bill> billsToSave = [];
    num totalPrice = 0.0;

    final previousMonthBills =
        await billRepository.getBillsByDate(previousDate);

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
