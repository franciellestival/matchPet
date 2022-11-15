import 'package:api_services/api_services.dart';
import 'package:get/get.dart' as getx;
import 'package:user_profile/model/new_user.dart';
import 'package:user_profile/model/token.dart';

class UserServices {
  static const String _userEndpoint = "/user";
  static const String _loginEndpoint = "/auth/login";

  final APIServices apiClient;

  UserServices({required this.apiClient});

  //Cria um novo usuario no backend
  Future<Response> createUser(NewUser user) async {
    try {
      final Response response =
          await apiClient.post(_userEndpoint, data: user.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Retorna os dados de um usuario a partir do seu ID
  Future<Response> getUserById(int id) async {
    try {
      final Token token = getx.Get.find(tag: "userToken");
      final Response response = await apiClient.get("$_userEndpoint/$id",
          options: Options(headers: {"Authorization": token.token.toString()}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Retorna os dados de todos os usuarios registrados
  Future<Response> getAllUsers() async {
    try {
      final Token token = getx.Get.find(tag: "userToken");
      final Response response = await apiClient.get(_userEndpoint,
          options: Options(headers: {"Authorization": token.token.toString()}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Atualiza os dados de um usuario
  Future<Response> updateUser(int id, NewUser user) async {
    try {
      final Token token = getx.Get.find(tag: "userToken");
      final Response response = await apiClient.put("$_userEndpoint/$id",
          data: user.toJson(),
          options: Options(headers: {"Authorization": token.token.toString()}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Deleta um usuario
  Future<Response> deleteUser(int id) async {
    try {
      final Token token = getx.Get.find(tag: "userToken");
      final Response response = await apiClient.delete("$_userEndpoint/$id",
          options: Options(headers: {"Authorization": token.token.toString()}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Efetua o login do usuario
  Future<Response> login(String email, String password) async {
    try {
      final Response response = await apiClient
          .post(_loginEndpoint, data: {"email": email, "password": password});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
