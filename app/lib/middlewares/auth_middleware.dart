import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../services/authentication_manager.dart';
import '../routes/app_routes.dart';

//Middleware para redirecionamento do usuario logado

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthenticationManager _authManager = Get.find();
    return _authManager.isLogged.value
        ? const RouteSettings(name: Routes.statusRoute)
        : null;
  }
}
