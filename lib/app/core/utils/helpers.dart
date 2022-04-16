import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppHelpers {
  static String monthResolver(int month) {
    final months = [
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

  static String categoryResolver(int categoryId) {
    switch (categoryId) {
      case 1:
        return 'houseBills'.tr;
      case 2:
        return 'foodAndDrink'.tr;
      case 3:
        return 'gamesAndStreaming'.tr;
      case 4:
        return 'personalCare'.tr;
      case 5:
        return 'others'.tr;
      default:
        return 'others'.tr;
    }
  }

  static Color billStatusResolver(int status) {
    switch (status) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.yellow;
      case 2:
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
