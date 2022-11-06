import 'package:api_services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:user_profile/model/new_user.dart';

class UserServices {
  static const String _userEndpoint = "/user";
  final APIServices apiClient;

  UserServices({required this.apiClient});

  //Cria um novo usuario no backend
  Future<Response> createUser(NewUser user) async {
    try {
      final Response response = await apiClient.post(
        _userEndpoint,
        data: user,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Retorna os dados de um usuario a partir do seu ID
  Future<Response> getUserById(int id) async {
    try {
      final Response response = await apiClient.get("$_userEndpoint/$id");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Retorna os dados de todos os usuarios registrados
  Future<Response> getAllUsers() async {
    try {
      final Response response = await apiClient.get(
        _userEndpoint,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Atualiza os dados de um usuario
  Future<Response> updateUser(int id, NewUser user) async {
    try {
      final Response response = await apiClient.put(
        "$_userEndpoint/$id",
        data: user,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Deleta um usuario
  Future<Response> deleteUser(int id) async {
    try {
      final Response response = await apiClient.delete("$_userEndpoint/$id");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
