import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:theme/export_theme.dart';

import '../controller/user_controller.dart';
import '../model/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _pwConfirmationController = TextEditingController();
  Rx<bool> inputEnabled = Rx<bool>(false);
  User user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var phoneFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    _nameController.text = user.name!;
    _phoneController.text = user.phone!;
    _emailController.text = user.email!;

    return Obx(() {
      return Scaffold(
        appBar: GenericAppBar(title: 'Meu Perfil', appBar: AppBar()),
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                            backgroundColor: inputEnabled.value
                                ? null
                                : Colors.grey.withOpacity(0.5),
                            enable: inputEnabled.value,
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
                            textInputType: TextInputType.phone,
                            backgroundColor: inputEnabled.value
                                ? null
                                : Colors.grey.withOpacity(0.5),
                            enable: inputEnabled.value,
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
                            textInputType: TextInputType.emailAddress,
                            backgroundColor: inputEnabled.value
                                ? null
                                : Colors.grey.withOpacity(0.5),
                            enable: inputEnabled.value,
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
                            backgroundColor: inputEnabled.value
                                ? null
                                : Colors.grey.withOpacity(0.5),
                            inputEnabled: inputEnabled.value,
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
                            backgroundColor: inputEnabled.value
                                ? null
                                : Colors.grey.withOpacity(0.5),
                            inputEnabled: inputEnabled.value,
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
                            child: inputEnabled.value
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PrimaryButton(
                                        width: 170,
                                        onTap: () => {_editUser()},
                                        text: 'Salvar',
                                      ),
                                      PrimaryButton(
                                        width: 170,
                                        onTap: () =>
                                            {inputEnabled.value = false},
                                        text: 'Cancelar',
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PrimaryButton(
                                          width: 170,
                                          onTap: () =>
                                              {inputEnabled.value = true},
                                          text: 'Editar'),
                                      PrimaryButton(
                                          width: 170,
                                          onTap: () =>
                                              {inputEnabled.value = true},
                                          text: 'Excluir'),
                                    ],
                                  ),
                          ),
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
    });
  }

  Future<void> _editUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await UserController.updateUser(
            user.id,
            _nameController.text,
            _phoneController.text,
            _emailController.text,
            _pwController.text,
            _pwConfirmationController.text);
        Get.snackbar("Sucesso!", "Usuário alterado com sucesso!");
      } catch (e) {
        Get.snackbar("Erro!", e.toString());
      }
      inputEnabled.value = false;
    }
  }
}
