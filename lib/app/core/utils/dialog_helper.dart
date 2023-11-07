import 'package:flutter/material.dart';

class DialogHelper {
  DialogHelper._();

  static DialogHelper instance = DialogHelper._();

  Future showDecisionDialog(
    BuildContext context, {
    IconData? icon,
    required String title,
    required String content,
    String? cancelText,
    String? confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Icon(
                  icon ?? Icons.warning,
                  size: 30,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.7),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onCancel != null) onCancel();
                      },
                      child: Text(
                        cancelText ?? 'Cancelar',
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onConfirm != null) onConfirm();
                      },
                      child: Text(
                        confirmText ?? 'Confirmar',
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
