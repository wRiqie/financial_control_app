import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  void showSnackbar({
    String? title,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    SnackPosition? position,
    Icon? icon, 
  }) {
    Get.rawSnackbar(
      title: title,
      message: message,
      snackPosition: position ?? SnackPosition.TOP,
      borderRadius: 8,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      backgroundColor: backgroundColor ?? Get.theme.colorScheme.error,
      icon: icon,
    );
  }
}
