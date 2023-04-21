import '../../core/values/constants.dart';
import '../pages.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

bool authenticated = false; 

class AuthMiddleware extends GetMiddleware {
  final box = GetStorage(Constants.storageName);

  @override
  RouteSettings? redirect(String? route) {
    if(kDebugMode) print('[Middleware] -> $authenticated');
    final authEnabled = box.read(Constants.biometryEnabled);
    if(authEnabled != null && authEnabled && !authenticated) {
      return const RouteSettings(name: Routes.auth);
    }
    return null;
  }
}
