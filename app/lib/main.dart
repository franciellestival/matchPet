import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:matchpet/routes/app_pages.dart';
import 'package:matchpet/routes/app_routes.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'MatchPet',
    getPages: AppPages.routes,
    initialRoute: Routes.initialRoute,
  ));
}
