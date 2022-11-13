import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matchpet/Pages/initial_page.dart';
import 'package:matchpet/authentication_manager.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/pages/pet_register_page.dart';
import 'package:user_profile/pages/login_page.dart';
import 'package:user_profile/pages/register_page.dart';
import 'package:user_profile/pages/status_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.initialRoute,
      page: () => const InitialPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.loginRoute,
      page: () => const UserLogin(),
    ),
    GetPage(
      name: Routes.registerRoute,
      page: () => UserRegister(),
    ),
    GetPage(
      name: Routes.statusRoute,
      page: () => StatusPage(),
    ),
    GetPage(
      name: Routes.petRegisterRoute,
      page: () => PetRegisterPage(),
    ),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthenticationManager _authManager = Get.find();
    return _authManager.isLogged.value
        ? const RouteSettings(name: Routes.statusRoute)
        : null;
  }
}
