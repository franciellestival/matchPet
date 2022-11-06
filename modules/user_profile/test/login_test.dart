import 'package:api_services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_profile/services/login_service.dart';

void main() {
  test('Test Login request', () async {
    try {
      final login = LoginService(apiClient: APIServices(Dio()));
      final response = await login.login("userteste2@email.com", "teste123");
      print(response);
    } catch (e) {
      print(e);
    }
  });
}
