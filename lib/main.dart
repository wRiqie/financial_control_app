import 'package:financial_control_app/app/core/theme/dark/dark_theme.dart';
import 'package:financial_control_app/app/core/values/contants.dart';
import 'package:financial_control_app/app/core/values/translation.dart';
import 'package:financial_control_app/app/modules/splash/splash_binding.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(Constants.storageName);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Financial App',
      theme: darkTheme,
      getPages: AppPages.pages,
      initialRoute: Routes.splash,
      initialBinding: SplashBinding(),
      translationsKeys: AppTranslation().keys,
      locale: Get.deviceLocale ?? const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}