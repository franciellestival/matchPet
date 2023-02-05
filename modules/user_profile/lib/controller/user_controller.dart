import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';

import 'package:matchpet/services/authentication_manager.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:url_launcher/url_launcher.dart';
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
      final AuthenticationManager authManager =
          Get.find<AuthenticationManager>();
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
      final AuthenticationManager authManager =
          Get.find<AuthenticationManager>();
      authManager.logOut();
      if (Get.isRegistered<User>(tag: "loggedInUser")) {
        Get.delete<User>(tag: "loggedInUser", force: true);
      }
      Get.offAllNamed(Routes.initialRoute);
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

  static Future<void> openWhatsApp(PetProfile pet,
      {bool adoption = true}) async {
    String phone = pet.owner?.phone?.replaceAll(RegExp(r'[^\d]'), '') ?? '';
    if (phone.isEmpty) {
      return;
    }
    String message = adoption
        ? "Olá, ${pet.owner?.name ?? ''}!. Encontrei seu pet ${pet.name} para adoção no MatchPet e gostaria de mais infomações!"
        : "Olá, ${pet.owner?.name ?? ''}!. Posso ter informações sobre seu pet ${pet.name} desaparecido!";
    String scheme = Platform.isAndroid ? 'https' : 'whatsapp';
    Uri waUri = Uri(
      scheme: scheme,
      host: 'wa.me',
      path: 'send',
      queryParameters: {
        'phone': '55$phone',
        'text': message,
      },
    );

    if (await canLaunchUrl(waUri)) {
      await launchUrl(waUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch';
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
  // final String address = place.street!.toString();
  final String address = place.subAdministrativeArea.toString();
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
