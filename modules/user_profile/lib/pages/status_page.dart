import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:matchpet/services/authentication_manager.dart';
import 'package:pet_profile/pages/pet_list_page.dart';
import 'package:theme/export_theme.dart';

import '../controller/user_controller.dart';
import '../model/token.dart';
import '../model/user.dart';

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  final AuthenticationManager _authManager = Get.find();

  final Token userToken = Get.find(tag: "userToken");

  late String msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<User?>(
                future: _getUser(),
                builder: ((context, snapshot) {
                  String msg =
                      'Vish! Algo deu errado. \n\n  Chamaremos os universitários!';
                  if (snapshot.hasData) {
                    User? user = snapshot.data;
                    if (user != null) {
                      msg =
                          "Usuário ${user.name} conectado com sucesso - email: ${user.email}";
                    }
                  }
                  return Text(msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, color: AppColors.buttonColor));
                }),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: PrimaryButton(
                  onTap: () => {_logout()}, text: 'Voltar ao início'),
            ),
            const SizedBox(height: 30),
            Center(
              child: PrimaryButton(
                  onTap: () => {Get.toNamed(Routes.petRegisterRoute)},
                  text: 'Cadastrar Pet'),
            ),
            const SizedBox(height: 30),
            Center(
              child: PrimaryButton(
                  onTap: () => {Get.toNamed(Routes.userProfile)},
                  text: 'Ver meu Perfil'),
            ),
            const SizedBox(height: 30),
            Center(
              child: PrimaryButton(
                  onTap: () => {Get.toNamed(Routes.petListPage)},
                  text: 'Ver lista de Pets'),
            ),
          ],
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
}
