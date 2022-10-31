import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:matchpet_poc/routes/app_routes.dart';
import 'package:user_profile/model/user.dart';

class APIUserServices {
  static String baseURL = 'https://matchpet-api-staging.herokuapp.com/';
  static String userEndpoint = 'user';
  static String authEndpoint = '/auth/login';

  //Faz a requisição para criar um usuário, e caso tenha sucesso, retorna um User cadastrado e logado
  //
  Future<User?> saveUser(User user) async {
    var requestBody = jsonEncode(user.toJson());
    try {
      var url = Uri.parse(baseURL + userEndpoint);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: requestBody,
      );
      if (response.statusCode == 201) {
        var userSignedUp = loginUser(user);
        return userSignedUp;
      } else {
        var messages = jsonDecode(response.body)['message'] as List;
        List<APIErrorMessageUser> errors =
            messages.map((e) => APIErrorMessageUser.fromJson(e)).toList();
        throw Exception(
            "Status Code: ${response.statusCode} - Messages: ${errors.toString()}");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return null;
  }

  //Faz a requisição de um usuário pelo seu ID
  //
  Future<User?> getUserById(String token, int? id) async {
    if (id! <= 0) {
      return null;
    }
    try {
      var url = Uri.parse(baseURL + userEndpoint + "/$id");
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
      );
      if (response.statusCode == 200) {
        var user = User.fromJson(jsonDecode(response.body));
        user.id = id;
        user.token = token;
        return user;
      } else {
        var messages = jsonDecode(response.body)['message'] as List;
        List<APIErrorMessageUser> errors =
            messages.map((e) => APIErrorMessageUser.fromJson(e)).toList();
        throw Exception(
            "Status Code: ${response.statusCode} - Messages: ${errors.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //Faz a requisição de todos os usuários
  //
  Future<List<User>?> getUsers(String token) async {
    try {
      var url = Uri.parse(baseURL + userEndpoint);
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
      );
      if (response.statusCode == 200) {
        var usersListJson = jsonDecode(response.body) as List;
        List<User> users = usersListJson.map((e) => User.fromJson(e)).toList();
        return users;
      } else {
        var messages = jsonDecode(response.body)['message'] as List;
        List<APIErrorMessageUser> errors =
            messages.map((e) => APIErrorMessageUser.fromJson(e)).toList();
        throw Exception(
            "Status Code: ${response.statusCode} - Messages: ${errors.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //Faz a requisição de atualizacao de um usuario
  //
  Future<User?> updateUser(String token, User user) async {
    try {
      var url = Uri.parse(baseURL + userEndpoint + "/${user.id}");
      var response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return getUserById(token, user.id);
      } else {
        var messages = jsonDecode(response.body)['message'] as List;
        List<APIErrorMessageUser> errors =
            messages.map((e) => APIErrorMessageUser.fromJson(e)).toList();
        throw Exception(
            "Status Code: ${response.statusCode} - Messages: ${errors.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //Faz a requisição de remoção de um usuario
  //
  Future<bool> deleteUser(String token, int? id) async {
    if (id! <= 0) {
      return false;
    }

    try {
      var url = Uri.parse(baseURL + userEndpoint + "/$id");
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        var messages = jsonDecode(response.body)['message'] as List;
        List<APIErrorMessageUser> errors =
            messages.map((e) => APIErrorMessageUser.fromJson(e)).toList();
        throw Exception(
            "Status Code: ${response.statusCode} - Messages: ${errors.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  //Faz a requisição de login, retornando um User logado (com token)
  //
  Future<User?> loginUser(User user) async {
    User? _userSignedIn;

    try {
      var url = Uri.parse(baseURL + authEndpoint);
      var requestBody =
          jsonEncode({'email': user.email, 'password': user.password});
      var response = await http.post(
        url,
        body: requestBody,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      //Se a resposta teve sucesso, executa a busca dos demais dados do user
      //
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        User? _userSignedIn;
        if ((user.id == null) || (user.id! <= 0)) {
          _userSignedIn = await getUserById(
              responseJson['token'] as String, responseJson['id'] as int);
        } else {
          user.id = responseJson['id'] as int;
          user.token = responseJson['token'] as String;
          _userSignedIn = user;
        }
        return _userSignedIn;
      } else {
        // Get.toNamed(Routes.STATUS, arguments: _userSignedIn);
        throw Exception(
            "Status Code: ${response.statusCode} - Message: ${jsonDecode(response.body).toString()}");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return null;
  }
}

class APIErrorMessageUser {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? passwordConfirmation;

  APIErrorMessageUser(
      {this.name,
      this.phone,
      this.email,
      this.password,
      this.passwordConfirmation});

  factory APIErrorMessageUser.fromJson(dynamic json) => APIErrorMessageUser(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confimation'] as String?);

  @override
  String toString() {
    return "Name:$name - Phone:$phone - Email:$email - Password:$password - Password Confirmation:$passwordConfirmation";
  }
}
