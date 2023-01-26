import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';

import 'package:matchpet/services/authentication_manager.dart';

class SplashDependency {
  Future<void> initializeSettings() async {
    //Inicializa o acesso ao storage

    await GetStorage.init();

    _loggedUserDependencies();

    //Espera 3 segundos
    await Future.delayed(const Duration(seconds: 3));

    //Remove a Splash Screen
    FlutterNativeSplash.remove();

    await _getLocationPermission();

    _requestNotificationPermission();
  }

  void _loggedUserDependencies() {
    //Injeta o Gerenciador de Autenticação
    final AuthenticationManager _authManager = Get.put(AuthenticationManager());

    //Verifica se o usuario ja estava logado
    _authManager.checkLoginStatus();
  }

  Future<void> _getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  void _requestNotificationPermission() async {
    //Configuração da permissão de notificação.

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('FIREBASE PERMISSION: PERMITIDO');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('FIREBASE PERMISSION: PERMITIDO PARCIALMENTE');
    } else {
      log('FIREBASE PERMISSION: NEGADO');
    }
  }
}
