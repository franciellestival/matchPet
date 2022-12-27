import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:theme/export_theme.dart';
import 'package:theme/widgets/bottom_nav_bar.dart';

import '../controller/user_controller.dart';
import '../model/token.dart';
import '../model/user.dart';

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  final Token userToken = Get.find(tag: "userToken");

  late String msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder<User?>(
          future: _getUser(),
          builder: ((context, snapshot) {
            String msg = "Carregando...";
            late User? user;
            if (snapshot.hasData) {
              user = snapshot.data;
              msg = (user == null)
                  ? "Usuário não encontrado!"
                  : "Usuário ${user.name} conectado com sucesso - email: ${user.email}";
            } else if (snapshot.hasError) {
              msg =
                  'Vish! Algo deu errado. \n\n  Chamaremos os universitários!';
            }

            return Column(
              children: [
                const SizedBox(height: 200),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(msg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 28, color: AppColors.buttonColor))),
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
                      onTap: () => {Get.toNamed(Routes.petListPage)},
                      text: 'Ver Pets'),
                ),
                const SizedBox(height: 30),
                Center(
                  child: PrimaryButton(
                      onTap: () =>
                          {Get.toNamed(Routes.userProfile, arguments: user)},
                      text: 'Ver meu Perfil'),
                ),
                const SizedBox(height: 30),
                Center(
                  child: PrimaryButton(
                      onTap: () => {Get.toNamed(Routes.petDetailPage)},
                      text: 'Detalhe do Pet'),
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
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
