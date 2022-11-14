import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/authentication_manager.dart';

class SplashDependency {
  Future<void> initializeSettings() async {
    //Inicializa o acesso ao storage
    await GetStorage.init();
    //Injeta o Gerenciador de Autenticação
    final AuthenticationManager _authManager = Get.put(AuthenticationManager());
    //Verifica se o usuario ja estava logado
    _authManager.checkLoginStatus();
    //Espera 3 segundos
    await Future.delayed(const Duration(seconds: 3));
    //Remove a Splash Screen
    FlutterNativeSplash.remove();
  }
}
