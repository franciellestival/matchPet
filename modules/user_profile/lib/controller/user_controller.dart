import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:matchpet/services/authentication_manager.dart';
import 'package:user_profile/repository/user_repository.dart';
import 'package:user_profile/model/new_user.dart';
import 'package:user_profile/model/token.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/model/user_location.dart';

class UserController {
  static Future<void> signUpUser(String name, String phone, String email,
      String password, String passwordConfirmation) async {
    try {
      UserLocation? location = await _getCurrentLocation();
      NewUser user = NewUser(
        name: name,
        phone: phone,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        location: location,
      );
      final UserRepository userRepository = Get.find();
      await userRepository.addNewUserRequested(user);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Token> loginUser(String email, String password) async {
    try {
      final UserRepository userRepository = Get.find();
      Token token = await userRepository.loginRequested(email, password);
      final AuthenticationManager authManager = Get.find();
      authManager.login(token);
      await getFirebaseDeviceToken();
      return token;
    } catch (e) {
      log("Erro: ${e.toString()}");
      rethrow;
    }
  }

  static Future<void> logoutUser() async {
    try {
      final AuthenticationManager authManager = Get.find();
      authManager.logOut();
    } catch (e) {
      log("Erro: ${e.toString()}");
      rethrow;
    }
  }

  static Future<User?> getLoggedUserData(Token userToken) async {
    try {
      //Puxa os dados do usuario
      final UserRepository userRepository = Get.find();
      final User? user = await userRepository.getUserById(userToken.id!);
      return user;
    } catch (e) {
      log("Erro: ${e.toString()}");
      rethrow;
    }
  }

  static Future<void> updateUser(int? id, String name, String phone,
      String email, String password, String passwordConfirmation) async {
    if (id == null) {
      throw "Id do usuário inválido!";
    }
    try {
      UserLocation? location = await _getCurrentLocation();
      NewUser user = NewUser(
        name: name,
        phone: phone,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        location: location,
      );
      final UserRepository userRepository = Get.find();
      await userRepository.updateUserRequested(id, user);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteUser(int? id) async {
    try {
      final UserRepository userRepository = Get.find();
      await userRepository.deleteUserRequested(id!);
    } catch (e) {
      rethrow;
    }
  }
}

Future<UserLocation?> _getCurrentLocation() async {
  Position? position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  List<Placemark>? placemarks = await placemarkFromCoordinates(
      position.latitude, position.longitude,
      localeIdentifier: 'pt_BR');

  if (placemarks.isEmpty) {
    return null;
  }
  Placemark place = placemarks[0];
  final String address = place.street!.toString();
  final UserLocation userLocation = UserLocation(
      lat: position.latitude, lng: position.longitude, address: address);
  return userLocation;
}

void saveFirebaseToken(String token) async {
  final Token userToken = Get.find(tag: "userToken");

  final user = await UserController.getLoggedUserData(userToken);

  if (user != null) {
    log('FIREBASE: USER ID : ${user.id} DEVICE TOKEN $token');
    await FirebaseFirestore.instance
        .collection("userDeviceToken")
        .doc("${user.id}")
        .set({"deviceToken": token});
  }
}

Future<void> getFirebaseDeviceToken() async {
  await FirebaseMessaging.instance.getToken().then((token) {
    saveFirebaseToken(token ?? '');
  });
}
