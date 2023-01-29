import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matchpet/routes/app_routes.dart';

import 'package:theme/export_theme.dart';

import 'package:user_profile/controller/user_controller.dart';
import 'package:user_profile/model/token.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/pages/wanted_pets.dart';

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  final Token userToken = Get.find<Token>(tag: "userToken");

  static const padding = EdgeInsets.symmetric(horizontal: 8.0);

  @override
  Widget build(BuildContext context) {
    User loggedInUser = Get.find<User>(tag: "loggedInUser");
    String msg = "Olá, ${loggedInUser.name} !";

    return Scaffold(
      appBar: const GenericAppBar(title: 'Meu Perfil'),
      backgroundColor: AppColors.primaryLightColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: padding,
                  child: Ink(
                    decoration: ShapeDecoration(
                        shadows: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        color: AppColors.primaryColor),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        AppSvgs.menuIcon,
                        height: 30,
                        width: 30,
                      ),
                      onPressed: () => {
                        Get.toNamed(Routes.userProfile,
                            arguments: loggedInUser),
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: padding,
                  child: Ink(
                    decoration: ShapeDecoration(
                        shadows: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: AppColors.primaryColor),
                    child: TextButton(
                      onPressed: (() {
                        _logout();
                      }),
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: AppColors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SvgPicture.asset(AppSvgs.appIcon),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _buildFrame(
              icon: AppSvgs.animalsIcon,
              text: 'Todos os meus pets',
              onPressed: () {
                Map<String, dynamic> filters = {};
                filters["userId"] = loggedInUser.id;

                Get.toNamed(Routes.searchResultPage, arguments: filters);
              },
            ),
            _buildFrame(
              icon: AppSvgs.dogIcon,
              text: 'Pets Disponíveis',
              onPressed: () {
                Map<String, dynamic> filters = {};
                filters["userId"] = loggedInUser.id;
                filters["status"] = "available";

                Get.toNamed(Routes.searchResultPage, arguments: filters);
              },
            ),
            _buildFrame(
              icon: AppSvgs.disappearedOutlined,
              text: 'Pets Desaparecidos',
              onPressed: () {
                Map<String, dynamic> filters = {};
                filters["userId"] = loggedInUser.id;
                filters["status"] = "missing";

                Get.toNamed(Routes.searchResultPage, arguments: filters);
              },
            ),
            _buildFrame(
              icon: AppSvgs.catIcon,
              text: 'Pets Adotados',
              onPressed: () {
                Map<String, dynamic> filters = {};
                filters["userId"] = loggedInUser.id;
                filters["status"] = "adopted";

                Get.toNamed(Routes.searchResultPage, arguments: filters);
              },
            ),
            _buildFrame(
              icon: AppSvgs.checkAdopters,
              text: 'Avaliar Interessados',
              onPressed: () {
                Get.to(WantedPets(
                  loggedUserId: loggedInUser.id!,
                  isMyWantedPets: false,
                ));
              },
            ),
            _buildFrame(
              icon: AppSvgs.housePet,
              text: 'Meus futuros Pets',
              onPressed: () {
                Get.to(WantedPets(
                  loggedUserId: loggedInUser.id!,
                  isMyWantedPets: true,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  _logout() async {
    await UserController.logoutUser();
  }

  Widget _buildFrame(
      {required String icon,
      required String text,
      required Function() onPressed}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Ink(
            decoration: ShapeDecoration(
                // ignore: prefer_const_literals_to_create_immutables
                shadows: [
                  const BoxShadow(
                    color: AppColors.buttonColor,
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: AppColors.primaryColor),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor)),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      icon,
                      height: 50,
                      width: 50,
                      color: Colors.brown,
                    ),
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
