import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final Icon? icon;
  final String body;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isInfoDialog;
  const ConfirmDialog({
    Key? key,
    this.title,
    this.icon,
    required this.body,
    this.onCancel,
    this.onConfirm,
    this.isInfoDialog = false,
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
              if(onConfirm != null) onConfirm!();
            },
            child: !isInfoDialog ? const Text('Confirmar') : const Text('Ok'),
          ),
        ),
        !isInfoDialog ? SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              onCancel != null ? onCancel!() : Get.back();
            },
            child: const Text('Cancelar'),
          ),
        ) : Container(),
      ],
    );
  }
}
