import 'package:financial_control_app/app/data/enums/bill_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppHelpers {
  static final months = [
    'jan'.tr,
    'feb'.tr,
    'mar'.tr,
    'apr'.tr,
    'may'.tr,
    'jun'.tr,
    'jul'.tr,
    'aug'.tr,
    'sep'.tr,
    'oct'.tr,
    'nov'.tr,
    'dec'.tr,
  ];

  static String monthResolver(int month) {
    return months[month - 1];
  }

  static String formatCurrency(num value) {
    var formatted = NumberFormat.simpleCurrency(
            locale: Get.deviceLocale?.toString() ??
                const Locale('en', 'US').toString())
        .format(value)
        .toString();
    return formatted;
  }

  static Color billStatusResolver(int status) {
    var billStatus = BillStatusExtension.getById(status); 
    switch (billStatus) {
      case EBillStatus.overdue:
        return Colors.red;
      case EBillStatus.pendent:
        return Colors.yellow;
      case EBillStatus.paid:
        return Colors.green;
      default:
        return Colors.green;
    }
  }

  static String formatDateBR(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatDateToSave(DateTime date) {
    return DateFormat('MM-yyyy').format(date);
  }

  static DateTime revertDateFromSave(String date) {
    return DateFormat('MM-yyyy').parse(date);
  }

  static num revertCurrencyFormat(String currency) {
    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
    return formatter.parse(currency);
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(
        locale: Get.deviceLocale?.toString() ??
            const Locale('en', 'US').toString());

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
