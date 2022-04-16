import 'package:financial_control_app/app/core/values/images.dart';
import 'package:financial_control_app/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                AppImages.financeLogo,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Finances App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Get.theme.colorScheme.onBackground
              ),
            ),
          ],
        ),
      ),
    );
  }
}
