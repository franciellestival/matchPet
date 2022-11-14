import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'di/home_binding.dart';
import 'di/splash_dependency.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await SplashDependency().initializeSettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MatchPet',
      getPages: AppPages.routes,
      initialRoute: Routes.initialRoute,
      theme: ThemeData(fontFamily: 'Lato'),
      initialBinding: HomeBinding(),
    );
  }
