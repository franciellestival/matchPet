import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:matchpet/authentication_manager.dart';

class SplashDependency {
  Future<void> initializeSettings() async {
    final AuthenticationManager _authManager = Get.put(AuthenticationManager());
    await GetStorage.init();
    _authManager.checkLoginStatus();
    // await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }
}
