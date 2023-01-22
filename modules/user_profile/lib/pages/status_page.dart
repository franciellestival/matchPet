import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matchpet/routes/app_routes.dart';

import 'package:theme/export_theme.dart';

import 'package:user_profile/controller/user_controller.dart';
import 'package:user_profile/model/token.dart';
import 'package:user_profile/model/user.dart';

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  final Token userToken = Get.find<Token>(tag: "userToken");

  static const padding = EdgeInsets.symmetric(horizontal: 8.0);

  @override
  Widget build(BuildContext context) {
    User? user;
    if (Get.isRegistered<User>(tag: "loggedInUser")) {
      user = Get.find<User>(tag: "loggedInUser");
    } else {
      Future.sync(() async => user = await _getUser());
    }
    String msg;
    return Scaffold(
      appBar: const GenericAppBar(title: 'Meu Perfil'),
      backgroundColor: AppColors.primaryLightColor,
      body: SingleChildScrollView(
        child: FutureBuilder<User?>(
          future: _getUser(),
          builder: ((context, snapshot) {
            msg = "Carregando...";
            late User? user;
            if (snapshot.hasData) {
              user = snapshot.data;
              msg = (user == null)
                  ? "Usuário não encontrado!"
                  : "Olá, ${user.name} !";
            } else if (snapshot.hasError) {
              msg =
                  'Vish! Algo deu errado. \n\n  Chamaremos os universitários!';
            }

            return Column(
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
                            Get.toNamed(Routes.userProfile, arguments: user),
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
                  icon: AppSvgs.dogIcon,
                  text: 'Meus Pets Disponíveis',
                  ontap: () => {},
                ),
                _buildFrame(
                  icon: AppSvgs.catIcon,
                  text: 'Meus Pets Adotados',
                  ontap: () => {},
                ),
                _buildFrame(
                  icon: AppSvgs.disappearedOutlined,
                  text: 'Meus Pets Desaparecidos',
                  ontap: () => {},
                ),
                _buildFrame(
                  icon: AppSvgs.animalsIcon,
                  text: 'Todos os meus pets',
                  ontap: () => {},
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  _logout() async {
    await UserController.logoutUser();
    return Get.offAndToNamed(Routes.initialRoute);
  }

  Future<User?> _getUser() async {
    return await UserController.getLoggedUserData(userToken);
  }

  Widget _buildFrame(
      {required String icon, required String text, required Function() ontap}) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  icon,
                  height: 50,
                  color: Colors.brown,
                ),
              ),
              TextButton(
                onPressed: ontap,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
