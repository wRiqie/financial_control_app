import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  void showSnackbar({
    required String title,
    required String subtitle,
    Color? backgroundColor,
    Color? textColor,
    SnackPosition? position,
    Icon? icon, 
  }) {
    Get.snackbar(
      title,
      subtitle,
      snackPosition: position ?? SnackPosition.TOP,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: icon,
    );
  }
}
