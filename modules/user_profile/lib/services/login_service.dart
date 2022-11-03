import 'package:api_services/api_services.dart';
import 'package:dio/dio.dart';

class LoginService {
  static const String _loginEndpoint = "/auth/login";

  final APIServices apiClient;

  LoginService({required this.apiClient});

  //Efetua o login do usuario
  Future<Response> login(String email, String password) async {
    try {
      final Response response = await apiClient
          .post(_loginEndpoint, data: {email: email, password: password});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
