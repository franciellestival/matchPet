import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:theme/export_theme.dart';
import 'package:user_profile/controller/user_controller.dart';

import '../model/token.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _pwConfirmationController = TextEditingController();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      UserController.signUpUser(
          _nameController.text,
          _phoneController.text,
          _emailController.text,
          _pwController.text,
          _pwConfirmationController.text);
      Token loggedToken = await UserController.loginUser(
          _emailController.text, _pwController.text);
      Get.offAndToNamed(Routes.statusRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    var phoneFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Scaffold(
      appBar: GenericAppBar(title: 'Cadastro de usuário', appBar: AppBar()),
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Wrap(
                      runSpacing: 22,
                      children: <Widget>[
                        Center(
                            child: ImageInput(
                                ontapIcon: () {},
                                placeHolderPath: AppSvgs.userIcon)),
                        const SizedBox(height: 20),
                        const Text(
                          'Informações pessoais',
                          style: TextStyle(fontSize: 16),
                        ),
                        FormInputBox(
                          hintText: 'Nome Completo',
                          controller: _nameController,
                          validator: (String? val) {
                            if (!val!.isValidName) {
                              return "Insira o nome completo.";
                            }
                            return null;
                          },
                        ),
                        FormInputBox(
                          hintText: 'Telefone',
                          controller: _phoneController,
                          inputFormatters: [phoneFormatter],
                          validator: (String? val) {
                            if (!val!.isValidPhone) {
                              return "Insira um número de telefone celular válido.";
                            }
                            return null;
                          },
                        ),
                        FormInputBox(
                          hintText: 'E-mail',
                          controller: _emailController,
                          validator: (String? val) {
                            if (!val!.isValidEmail) {
                              return "Insira um e-mail válido";
                            }
                            return null;
                          },
                        ),
                        FormInputBoxPassword(
                          hintText: 'Senha',
                          controller: _pwController,
                          validator: (String? val) {
                            if (!val!.isValidPassword) {
                              return "Senha deve possuir ao menos 8 caracteres.";
                            }
                            return null;
                          },
                        ),
                        FormInputBoxPassword(
                          hintText: 'Confirme sua senha',
                          controller: _pwConfirmationController,
                          validator: (String? val) {
                            if (!val!.isValidPassword) {
                              return "Confirmação de senha não é válida.";
                            }
                            return null;
                          },
                        ),
                        Center(
                            child: PrimaryButton(
                                onTap: _registerUser, text: 'Salvar')),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
