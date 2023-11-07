import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  // Biometry
  final auth = LocalAuthentication();

  Future<bool> checkDeviceCompatility(LocalAuthentication auth) async {
    final canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final canAuthenticate =
        canAuthenticateWithBiometrics && await auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<bool> authenticate() async {
    final isCompatible = await checkDeviceCompatility(auth);
    if (isCompatible) {
      final response = await auth.authenticate(
        localizedReason: 'Autentique-se para entrar no app',
      );
      return response;
    }
    return false;
  }
}
