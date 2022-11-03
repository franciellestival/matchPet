import 'package:api_services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:user_profile/model/new_user.dart';
import 'package:user_profile/services/user_endpoints.dart';

class UserServices {
  final APIServices apiClient;

  UserServices({required this.apiClient});

  //Cria um novo usuario no backend
  Future<Response> createUser(NewUser user) async {
    try {
      final Response response = await apiClient.post(
        UserEndpoints.endpoint,
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
      final Response response =
          await apiClient.get("${UserEndpoints.endpoint}/$id");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Retorna os dados de todos os usuarios registrados
  Future<Response> getAllUsers() async {
    try {
      final Response response = await apiClient.get(
        UserEndpoints.endpoint,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Atualiza os dados de um usuario
  Future<Response> updateUser(NewUser user) async {
    try {
      final Response response = await apiClient.put(
        UserEndpoints.endpoint,
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
      final Response response =
          await apiClient.delete("${UserEndpoints.endpoint}/$id");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
