import 'package:financial_control_app/app/core/values/translation.dart';
import 'package:financial_control_app/app/data/services/theme_service.dart';
import 'package:financial_control_app/app/modules/financial/financial_controller.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialApp extends GetView<FinancialController> {
  const FinancialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FinancialController>(
      init: FinancialController(),
      builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Financial App',
          theme: appTheme.currentTheme(),
          getPages: AppPages.pages,
          initialRoute: Routes.splash,
          translationsKeys: AppTranslation().keys,
          locale: Get.deviceLocale ?? const Locale('pt', 'BR'),
          fallbackLocale: const Locale('pt', 'BR'),
        );
      },
    );
  }
}
