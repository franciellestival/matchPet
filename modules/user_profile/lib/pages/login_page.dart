import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:theme/export_theme.dart';

import '../controller/user_controller.dart';
import '../model/token.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailLoginController = TextEditingController();
  final _passwordLoginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: 'Login', appBar: AppBar()),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.loginPagePhoto),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: SvgPicture.asset(
                        AppSvgs.appIcon,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Text(
                        'Match Pet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Form(
                      key: _formKey,
                      child: Wrap(
                        runSpacing: 20,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: FormInputBox(
                              backgroundColor: AppColors.primaryColor,
                              hintText: 'exemplo@matchpet.com',
                              controller: _emailLoginController,
                              validator: (String? val) {
                                if (!val!.isValidEmail) {
                                  return "Insira um e-mail válido";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: FormInputBoxPassword(
                              backgroundColor: AppColors.primaryColor,
                              hintText: 'Digite sua senha',
                              controller: _passwordLoginController,
                              validator: (String? val) {
                                if (!val!.isValidPassword) {
                                  return "Senha deve possuir ao menos 8 caracteres.";
                                }
                                return null;
                              },
                            ),
                          ),
                          Center(
                            child: PrimaryButton(
                              // onTap: signIn,
                              onTap: _signIn,
                              text: AppStrings.loginButton,
                              backgroundColor: AppColors.blueButton,
                            ),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () => {},
                              child: const Text(
                                'Esqueceu sua senha?',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text('Entrar com Uma rede social'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppSvgs.googleIcon),
                      //SvgPicture.asset(AppSvgs.facebookIcon),
                    ],
                  ),
                  const Text('Não possui conta ainda?'),
                  Center(
                    child: TextButton(
                      onPressed: () =>
                          {Get.offAndToNamed(Routes.registerRoute)},
                      child: const Text(
                        'Cadastre-se aqui',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    try {
      if (_formKey.currentState!.validate()) {
        Token loggedToken = await UserController.loginUser(
            _emailLoginController.text, _passwordLoginController.text);
        Get.offAndToNamed(Routes.statusRoute, arguments: loggedToken);
      }
    } on Exception catch (e) {
      Get.snackbar("Erro!", e.toString(), duration: const Duration(seconds: 5));
    }
  }
}
