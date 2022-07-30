import 'package:financial_control_app/app/core/values/constants.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

bool authenticated = false; 

class AuthMiddleware extends GetMiddleware {
  final box = GetStorage(Constants.storageName);

  @override
  RouteSettings? redirect(String? route) {
    print('[Middleware] -> $authenticated');
    final authEnabled = box.read(Constants.biometryEnabled);
    if(authEnabled != null && authEnabled && !authenticated) {
      return const RouteSettings(name: Routes.auth);
    }
    return null;
  }
}
