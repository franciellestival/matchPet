import 'dart:developer';

import 'package:api_services/api_services.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:matchpet/services/authentication_manager.dart';
import 'package:pet_profile/repository/pet_repository.dart';
import 'package:pet_profile/services/pet_services.dart';

import 'package:user_profile/model/token.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/repository/user_repository.dart';
import 'package:user_profile/services/user_services.dart';

import '../routes/app_routes.dart';

class HomeBinding extends Bindings {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  Future<void> dependencies() async {
    // Injeta o userRepository como dependencia para utilizacao no app
    APIServices api = APIServices(Dio());
    UserServices userServices = UserServices(apiClient: api);
    UserRepository userRepository = UserRepository(userServices);
    Get.put<UserRepository>(userRepository, permanent: true);

    PetServices petServices = PetServices(petApi: api);
    PetRepository petRepository = PetRepository(petServices);
    Get.put<PetRepository>(petRepository, permanent: true);

    if (Get.isRegistered<Token>(tag: "userToken")) {
      Token userToken = Get.find<Token>(tag: "userToken");
      final AuthenticationManager _authManager =
          Get.find<AuthenticationManager>();
      //Garante que o usuário logado ainda seja valido
      // Fazendo um get dele mesmo e verificando o retorno
      try {
        final User? thisUser = await userRepository.getUserById(userToken.id!);
        if (thisUser == null) {
          _authManager.logOut();
          if (Get.isRegistered<User>(tag: "loggedInUser")) {
            Get.delete<User>(tag: "loggedInUser", force: true);
          }
          Get.offAllNamed(Routes.initialRoute);
        }
      } catch (e) {
        _authManager.logOut();
        if (Get.isRegistered<User>(tag: "loggedInUser")) {
          Get.delete<User>(tag: "loggedInUser", force: true);
        }
        Get.offAllNamed(Routes.initialRoute);
      }
    }

    initNotificationInfo();
  }

  initNotificationInfo() {
    var androidInitialize = const AndroidInitializationSettings('@mipmap/logo');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      try {} catch (e) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((message) async {
      log("FIREBASE MESSAGE: ${message.notification?.title} / ${message.notification?.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatTitle: true);

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('matchpet_poc', 'matchpet_poc',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.max,
              playSound: false);

      NotificationDetails plataformChannelSpecifics = NotificationDetails(
          android: androidNotificationDetails,
          iOS: DarwinNotificationDetails());

      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, plataformChannelSpecifics,
          payload: message.data['body']);
    });
  }
}
