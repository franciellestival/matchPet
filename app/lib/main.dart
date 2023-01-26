import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:matchpet/firebase_options.dart';

import 'package:matchpet/routes/app_routes.dart';

import 'di/home_binding.dart';
import 'di/splash_dependency.dart';
import 'routes/app_pages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('FIREBASE BACKGROUNG SERVICE: ${message.data}');
}

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await SplashDependency().initializeSettings();

  await FirebaseMessaging.instance.getInitialMessage();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MatchPet',
      getPages: AppPages.routes,
      theme: ThemeData(fontFamily: 'Lato'),
      initialBinding: HomeBinding(),
      initialRoute: Routes.initialRoute,
    );
  }
}
