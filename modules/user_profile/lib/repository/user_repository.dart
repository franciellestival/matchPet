import 'dart:developer';

import 'package:api_services/api_services.dart';
import 'package:user_profile/model/new_user.dart';
import 'package:user_profile/model/token.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/services/user_services.dart';

class UserRepository {
  final UserServices userAPIServices;

  UserRepository(this.userAPIServices);

  //Retorna a lista de usuarios cadastrados
  Future<List<User>> getUsersRequested() async {
    try {
      final response = await userAPIServices.getAllUsers();
      final users =
          (response.data as List).map((e) => User.fromJson(e)).toList();
      return users;
    } on DioError catch (e) {
      final erro = APIExceptions.fromDioError(e);
      throw erro;
    }
  }

  //Retorna o usuario pelo id
  Future<User?> getUserById(int id) async {
    try {
      final response = await userAPIServices.getUserById(id);
      return User.fromJson(response.data);
    } on DioError catch (e) {
      final erro = APIExceptions.fromDioError(e);
      throw erro;
    }
  }

  // Cria um novo usuario, e retorna a mensagem de sucesso ou erro
  Future<String> addNewUserRequested(NewUser user) async {
    try {
      final response = await userAPIServices.createUser(user);
      return response.data["message"].toString();
    } on DioError catch (e) {
      final erro = APIExceptions.fromDioError(e);
      throw erro;
    }
  }

  //Atualiza o usuario e retorna a lista do mesmo
  Future<User> updateUserRequested(int id, NewUser user) async {
    try {
      final response = await userAPIServices.updateUser(id, user);
      return User.fromJson(response.data);
    } on DioError catch (e) {
      final erro = APIExceptions.fromDioError(e);
      throw erro;
    }
  }

  //Deleta o usuario
  Future<void> deleteUserRequested(int id) async {
    try {
      await userAPIServices.deleteUser(id);
    } on DioError catch (e) {
      final erro = APIExceptions.fromDioError(e);
      throw erro;
    }
  }

  // Faz o login do usuario a partir do seu email e senha
  Future<Token> loginRequested(String email, String password) async {
    try {
      final response = await userAPIServices.login(email, password);
      log(response.data.toString());
      return Token.fromJson(response.data);
    } on DioError catch (e) {
      log(e.toString());
      final erro = APIExceptions.fromDioError(e);
      throw erro;
    }
  }
}