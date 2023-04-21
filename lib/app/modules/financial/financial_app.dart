import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/translation.dart';
import '../../data/services/theme_service.dart';
import '../../routes/pages.dart';
import 'financial_controller.dart';

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
          theme: appTheme.currentTheme,
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
