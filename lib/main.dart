import 'package:financial_control_app/app/core/theme/dark/dark_theme.dart';
import 'package:financial_control_app/app/modules/dashboard/dashboard_binding.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: Routes.dashboard,
      initialBinding: DashboardBinding(),
    );
  }
}