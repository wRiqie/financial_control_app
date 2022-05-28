import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final Icon? icon;
  final String body;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  const ConfirmDialog({
    Key? key,
    this.title,
    this.icon,
    required this.body,
    this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: icon ?? Text(title ?? ''),
      content: Text(body),
      actions: [
        SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: const Text('Confirmar'),
          ),
        ),
        SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              onCancel != null ? onCancel!() : Get.back();
            },
            child: const Text('Cancelar'),
          ),
        ),
      ],
    );
  }
}
