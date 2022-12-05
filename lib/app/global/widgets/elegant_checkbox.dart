import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElegantCheckbox extends StatelessWidget {
  const ElegantCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox
        Container(
          color: Get.theme.colorScheme.primary,
          height: 20,
          width: 40,
          child: AnimatedAlign(
            alignment: Alignment.centerRight,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 20,
              width: 20,
              color: Get.theme.colorScheme.surface,
              child: Icon(
                Icons.done,
                size: 14,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        // Label
        const Text(
          'Já pago?',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
