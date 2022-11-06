import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';

import 'package:theme/export_theme.dart';

import 'package:user_profile/model/user.dart';

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  late User? user = Get.arguments;

  late String msg;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      msg =
          'Olá ${user!.name} você está cadastrado com o e-mail ${user!.email} \n\n Logo você poderá encontrar um pet para chamar de seu!';
    } else {
      msg = 'Vish! Algo deu errado. \n\n  Chamaremos os universitários!';
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 28, color: AppColors.buttonColor),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: PrimaryButton(
                  onTap: () => {Get.toNamed(Routes.initialRoute)},
                  text: 'Voltar ao início'),
            ),
            const SizedBox(height: 30),
            Center(
              child: PrimaryButton(
                  onTap: () => {Get.toNamed(Routes.petRegisterRoute)},
                  text: 'Cadastrar Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
