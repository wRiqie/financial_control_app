import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/enums/bill_status.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RegisterBillController extends GetxController {
  final BillRepository repository;
  final MonthRepository monthRepository;
  final uuid = const Uuid();
  final args = Get.arguments;
  int categoryId = 0;
  bool havePortions = false;
  bool paid = false;
  Month? selectedMonth;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final totalValueController = TextEditingController();
  final dueDateController = TextEditingController();
  final portionController = TextEditingController();
  final maxPortionController = TextEditingController();

  RegisterBillController(this.repository, this.monthRepository);

  togglePortion(bool? value) {
    havePortions = value ?? !havePortions;
    update();
  }

  togglePaid(bool? value) {
    paid = value ?? !paid;
    update();
  }

  saveBill({bool add = false}) async {
    if (formKey.currentState!.validate()) {
      Bill bill = Bill(
        id: uuid.v4(),
        categoryId: categoryId,
        title: titleController.text,
        value: AppHelpers.revertCurrencyFormat(totalValueController.text),
        dueDate: int.parse(dueDateController.text),
        portion: int.tryParse(portionController.text),
        maxPortion: int.tryParse(maxPortionController.text),
        status: status,
        date: AppHelpers.formatDateToSave(DateTime.now()),
      );

      await repository.saveBill(bill);

      titleController.text = '';
      totalValueController.text = '';
      dueDateController.text = '';
      portionController.text = '';
      maxPortionController.text = '';

      if (!add) {
        Get.back();
      }

      // Update Month
      if (selectedMonth != null && paid) {
        selectedMonth!.totalPrice =
            (selectedMonth!.totalPrice ?? 0) + bill.value;
        await monthRepository.saveMonth(selectedMonth!);
      }

      Get.snackbar(
        'Success',
        'Successfully saved',
        snackPosition: SnackPosition.TOP,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        backgroundColor: DarkColors.success,
        colorText: Get.theme.colorScheme.onSurface,
        icon: const Icon(Icons.done),
      );
    }
  }

  int get status {
    if(paid){
      return BillStatus.paid.index;
    }
    return DateTime.now().day > int.parse(dueDateController.text)
        ? BillStatus.overdue.index
        : BillStatus.pendent.index;
  }

  @override
  void onInit() {
    super.onInit();
    categoryId = args['categoryId'];
    selectedMonth = args['selectedMonth'];
  }
}
