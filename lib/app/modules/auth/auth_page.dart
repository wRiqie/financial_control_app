import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final size = Get.size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            Icon(
              Icons.lock,
              size: 36,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              'Financial app bloqueado',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: size.height * .3,
            ),
            Obx(
              () => GestureDetector(
                onTap: controller.authenticate,
                child: Icon(
                  Icons.fingerprint,
                  size: 48,
                  color: controller.result.value == null
                      ? theme.colorScheme.onBackground
                      : controller.result.value!
                          ? DarkColors.success
                          : DarkColors.error,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Toque no icone acima',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
