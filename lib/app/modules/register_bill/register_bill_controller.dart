import '../../core/utils/helpers.dart';
import '../../data/enums/bill_status_enum.dart';
import '../../data/models/bill.dart';
import '../../data/models/month.dart';
import '../../data/repository/bill_repository.dart';
import '../../data/repository/month_repository.dart';
import '../../data/services/snackbar_service.dart';
import '../home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RegisterBillController extends GetxController {
  final homeController = Get.find<HomeController>();
  final BillRepository repository;
  final MonthRepository monthRepository;
  final SnackbarService snackService;
  final args = Get.arguments;
  final uuid = const Uuid();
  int categoryId = 0;
  int? categoryIconPoint;
  bool havePortions = false;
  bool paid = false;
  Month? selectedMonth;

  Bill? editingBill;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final totalValueController = TextEditingController();
  final dueDateController = TextEditingController();
  final portionController = TextEditingController();
  final maxPortionController = TextEditingController();

  RegisterBillController(
      this.repository, this.monthRepository,
      {required this.snackService});

  togglePortion(bool? value) {
    havePortions = value ?? !havePortions;
    portionController.text = '';
    maxPortionController.text = '';
    update();
  }

  togglePaid(bool? value) {
    paid = value ?? !paid;
    update();
  }

  saveBill({bool add = false}) async {
    if (formKey.currentState!.validate()) {
      Bill bill = Bill(
        id: editingBill != null ? editingBill!.id : uuid.v4(),
        categoryId: categoryId,
        title: titleController.text,
        value: AppHelpers.revertCurrencyFormat(totalValueController.text),
        dueDate: int.parse(dueDateController.text),
        portion: int.tryParse(portionController.text),
        maxPortion: int.tryParse(maxPortionController.text),
        status: status,
        date: AppHelpers.formatDateToSave(DateTime.now()),
      );

      clearFields();

      await repository.saveBill(bill);

      // Update Month
      if (selectedMonth != null) {
        await homeController.loadMonth();
      }

      if (!add) {
        Get.back();
      }

      snackService.showSnackbar(
        title: 'success'.tr,
        message: 'successfullySaved'.tr,
      );
    }
  }

  int get status {
    if (paid) {
      return EBillStatus.paid.id;
    }
    return DateTime.now().day > int.parse(dueDateController.text)
        ? EBillStatus.overdue.id
        : EBillStatus.pendent.id;
  }

  fillFields() {
    titleController.text = editingBill?.title ?? '';
    totalValueController.text =
        AppHelpers.formatCurrency(editingBill?.value ?? 0);
    dueDateController.text = editingBill?.dueDate.toString() ?? '';
    portionController.text = editingBill?.portion?.toString() ?? '';
    maxPortionController.text = editingBill?.maxPortion?.toString() ?? '';

    paid = editingBill?.status == EBillStatus.paid.id ? true : false;
    havePortions = editingBill?.maxPortion != null ? true : false;
  }

  clearFields() {
    titleController.clear();
    totalValueController.clear();
    dueDateController.clear();
    portionController.clear();
    maxPortionController.clear();
    paid = false;
    havePortions = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    categoryId = args['categoryId'];
    categoryIconPoint = args['categoryIconPoint'];
    selectedMonth = args['selectedMonth'];
    
    if (args['bill'] != null) {
      editingBill = args['bill'];
      fillFields();
    } else {
      dueDateController.text = DateTime.now().day.toString();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    totalValueController.dispose();
    dueDateController.dispose();
    portionController.dispose();
    maxPortionController.dispose();
    super.dispose();
  }
}
