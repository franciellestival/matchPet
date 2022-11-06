import 'package:api_services/api_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:user_profile/model/new_user.dart';
import 'package:user_profile/model/token.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/services/login_service.dart';
import 'package:user_profile/services/user_services.dart';

class UserRepository {
  final UserServices userAPIServices;
  final LoginService loginAPIService;

  UserRepository(this.userAPIServices, this.loginAPIService);

  //Retorna a lista de usuarios cadastrados
  Future<List<User>> getUsersRequested() async {
    try {
      final response = await userAPIServices.getAllUsers();
      final users =
          (response.data as List).map((e) => User.fromJson(e)).toList();
      return users;
    } on DioError catch (e) {
      final errorMessage = APIExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  // Cria um novo usuario, e retorna a mensagem de sucesso ou erro
  Future<String> addNewUserRequested(NewUser user) async {
    try {
      final response = await userAPIServices.createUser(user);
      return "Usuário criado com sucesso!";
    } on DioError catch (e) {
      final errorMessage = APIExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  //Atualiza o usuario e retorna a lista do mesmo
  Future<User> updateUserRequested(int id, NewUser user) async {
    try {
      final response = await userAPIServices.updateUser(id, user);
      return User.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = APIExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  //Deleta o usuario
  Future<void> deleteUserRequested(int id) async {
    try {
      await userAPIServices.deleteUser(id);
    } on DioError catch (e) {
      final errorMessage = APIExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  // Faz o login do usuario a partir do seu email e senha
  Future<Token> loginRequested(String email, String password) async {
    try {
      final response = await loginAPIService.login(email, password);
      return Token.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = APIExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
