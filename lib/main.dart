import 'package:financial_control_app/app/core/theme/dark/dark_theme.dart';
import 'package:financial_control_app/app/data/services/bill_service.dart';
import 'package:financial_control_app/app/modules/dashboard/dashboard_binding.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const MyApp());
    },
  );
}

Future<void> initServices() async {
  print('starting services...');
  await Get.putAsync<BillService>(() => BillService().init());
  print('all services started');
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