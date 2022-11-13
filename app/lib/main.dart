import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:matchpet/di/home_binding.dart';
import 'package:matchpet/pages/splash_screen.dart';
import 'package:matchpet/routes/app_pages.dart';

import 'routes/app_routes.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MatchPet',
      getPages: AppPages.routes,
      initialRoute: Routes.initialRoute,
      home: SplashScreen(),
      initialBinding: HomeBinding(),
    );
  }
