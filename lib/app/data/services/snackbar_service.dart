import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/constants.dart';

abstract class _BaseSnackbar {
  SnackbarController? _currentBar;

  _BaseSnackbar(
      {String? title,
      required String message,
      Widget? icon,
      required Color backgroundColor,
      Color? textColor}) {
    _closeCurrent();
    Get.rawSnackbar(
      title: title,
      message: message,
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      backgroundColor: backgroundColor,
      icon: icon,
    );
  }

  void _closeCurrent() {
    _currentBar?.close();
  }
}

class SuccessSnackbar extends _BaseSnackbar {
  SuccessSnackbar({
    required String message,
    String? title,
    Widget? icon,
  }) : super(
          title: title,
          message: message,
          backgroundColor: const Color.fromARGB(255, 102, 140, 99),
          textColor: const Color.fromARGB(255, 255, 255, 255),
          icon: icon ??
              const Icon(
                Icons.check,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
        );
}

class AlertSnackbar extends _BaseSnackbar {
  AlertSnackbar({
    required String message,
    String? title,
    Widget? icon,
  }) : super(
          title: title,
          message: message,
          backgroundColor: Colors.orange,
          textColor: const Color.fromARGB(255, 255, 255, 255),
          icon: icon ??
              const Icon(
                Icons.warning,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
        );
}

class ErrorSnackbar extends _BaseSnackbar {
  ErrorSnackbar({
    String? message,
    String? title,
    Widget? icon,
  }) : super(
          title: title,
          message: message ?? Constants.defaultError,
          backgroundColor: const Color(0xFFF64343),
          textColor: const Color(0xFFFCFCFC),
          icon: icon ??
              const Icon(
                Icons.error,
                color: Color(0xFFFCFCFC),
              ),
        );
}
