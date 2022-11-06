import 'package:api_services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:user_profile/repository/user_repository.dart';
import 'package:user_profile/services/login_service.dart';
import 'package:user_profile/services/user_services.dart';

GetIt locator = GetIt.instance;

Future<void> setup() async {
  locator.registerSingleton(Dio());
  locator.registerSingleton(APIServices(locator<Dio>()));
  locator.registerSingleton(UserServices(apiClient: locator<APIServices>()));
  locator.registerSingleton(LoginService(apiClient: locator<APIServices>()));
  locator.registerSingleton(
      UserRepository(locator<UserServices>(), locator<LoginService>()));
}
