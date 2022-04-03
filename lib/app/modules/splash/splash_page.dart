import 'package:financial_control_app/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.monetization_on_outlined,
          size: 200,
          color: Get.theme.colorScheme.primary,
        ),
      ),
    );
  }
}
