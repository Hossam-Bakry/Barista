import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsService {
  BiometricsService._();

  factory BiometricsService() {
    _this ??= BiometricsService._();
    return _this!;
  }

  static BiometricsService? _this;

  final _localAuth = LocalAuthentication();

  Future<bool> _checkAvailableBiometrics() async {
    final canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
    final canAuthenticate =
        canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
    if (!canAuthenticate) return false;
    final availableBiometrics = await _localAuth.getAvailableBiometrics();
    return availableBiometrics.isNotEmpty;
  }

  Future<bool> authenticate() async {
    final canAuthenticate = await _checkAvailableBiometrics();
    if (!canAuthenticate) return false;
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to log into your account',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint('Error in biometric login: $e');
      return false;
    }
  }
}
