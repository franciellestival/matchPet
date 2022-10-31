import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet_poc/routes/app_routes.dart';
import 'package:theme/components/button_component.dart';
import 'package:theme/layout/app_config.dart';
import 'package:user_profile/model/user.dart';

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  late User? user = Get.arguments;

  late String msg;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      msg = 'Olá ' +
          user!.fullName.toString() +
          ' você está cadastrado com o e-mail ' +
          user!.email.toString() +
          ' \n\n Logo você poderá encontrar um pet para chamar de seu!';
    } else {
      msg = 'Vish! Algo deu errado. \n\n  Chamaremos os universitários!';
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 28, color: AppColors.buttonColor),
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: PrimaryButton(
                  onTap: () => {Get.toNamed(Routes.INITIAL)},
                  text: 'Voltar ao início'),
            ),
            SizedBox(height: 30),
            Center(
              child: PrimaryButton(
                  onTap: () => {Get.toNamed(Routes.PETREGISTER)},
                  text: 'Cadastrar Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
