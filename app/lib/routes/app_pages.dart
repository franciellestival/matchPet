import 'package:get/get.dart';
import 'package:matchpet_poc/Pages/initial_page.dart';
import 'package:matchpet_poc/routes/app_routes.dart';
import 'package:pet_profile/pages/pet_register_page.dart';
import 'package:user_profile/pages/login_page.dart';
import 'package:user_profile/pages/register_page.dart';
import 'package:user_profile/pages/status_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const InitialPage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const UserLogin(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const UserRegister(),
    ),
    GetPage(
      name: Routes.STATUS,
      page: () => StatusPage(),
    ),
    GetPage(
      name: Routes.PETREGISTER,
      page: () => PetRegisterPage(),
    ),
  ];
}
