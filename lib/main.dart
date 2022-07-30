import 'package:financial_control_app/app/core/values/constants.dart';
import 'package:financial_control_app/app/modules/financial/financial_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(Constants.storageName);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const FinancialApp());
    },
  );
}