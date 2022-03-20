import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppHelpers {
  static String monthResolver(int month) {
    final months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    // month - 1 = index
    return months[month - 1];
  }

  static String formatCurrency(double value) {
    var formatted =
        NumberFormat.simpleCurrency(locale: const Locale('pt', 'BR').toString())
            .format(value)
            .toString();
    return formatted;
  }

  static String categoryResolver(int categoryId) {
    switch (categoryId) {
      case 1:
        return 'House Bills';
      case 2:
        return 'Food and Drink';
      case 3:
        return 'Games And Streaming';
      case 4:
        return 'Personal care';
      case 5:
        return 'Others';
      default:
        return 'Others';
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
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
