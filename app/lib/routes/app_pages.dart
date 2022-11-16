import 'package:get/get.dart';

import 'package:pet_profile/pages/pet_list_page.dart';
import 'package:pet_profile/pages/pet_register_page.dart';
import 'package:user_profile/pages/login_page.dart';
import 'package:user_profile/pages/profile_page.dart';
import 'package:user_profile/pages/register_page.dart';
import 'package:user_profile/pages/status_page.dart';

import '../middlewares/auth_middleware.dart';
import '../pages/initial_page.dart';
import 'app_routes.dart';

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
    GetPage(
      name: Routes.userProfile,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: Routes.petListPage,
      page: () => PetListPage(),
    ),
  ];
}
