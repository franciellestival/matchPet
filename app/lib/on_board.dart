import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/pages/initial_page.dart';
import 'package:user_profile/pages/status_page.dart';

import 'authentication_manager.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager authManager = Get.find();

    return Obx(() {
      return authManager.isLogged.value ? StatusPage() : const InitialPage();
    });
  }
}
