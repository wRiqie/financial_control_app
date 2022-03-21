import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/enums/bill_status.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class RegisterBillController extends GetxController {
  final args = Get.arguments;
  int categoryId = 0;
  bool havePortions = false;
  DateTime selectedDate = DateTime.now();
  final uuid = const Uuid();

  List<Bill> bills = [];

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final totalValueController = TextEditingController();
  final dueDateController = TextEditingController();
  final portionController = TextEditingController();
  final maxPortionController = TextEditingController();

  togglePortion(bool? value) {
    havePortions = value ?? !havePortions;
    update();
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

  addBill() {
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
      );

      bills.add(bill);
    }
  }

  int get status {
    return DateTime.now().day > int.parse(dueDateController.text)
        ? BillStatus.overdue.index
        : BillStatus.pendent.index;
  }

  @override
  void onInit() {
    super.onInit();
    categoryId = args['categoryId'];
  }
}
