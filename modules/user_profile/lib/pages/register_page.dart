import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:theme/export_theme.dart';
import 'package:user_profile/controller/user_controller.dart';
import 'package:user_profile/model/token.dart';

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
  RxBool isLoading = false.obs;

  Future<void> _registerUser() async {
    isLoading.value = true;
    if (_formKey.currentState!.validate()) {
      try {
        await UserController.signUpUser(
            _nameController.text,
            _phoneController.text,
            _emailController.text,
            _pwController.text,
            _pwConfirmationController.text);
        final loggedToken = await UserController.loginUser(
            _emailController.text, _pwController.text);

        Get.offAndToNamed(Routes.home);
        Get.put<Token>(loggedToken, tag: "userToken", permanent: true);
      } on Exception catch (e) {
        Get.snackbar("Erro!", e.toString(),
            duration: const Duration(seconds: 5));
      }
    }
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    var phoneFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Scaffold(
      appBar: const GenericAppBar(
          title: 'Cadastro de usuário', showBackArrow: false),
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: SvgPicture.asset(
                        AppSvgs.appIcon,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Wrap(
                      runSpacing: 22,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        const Text(
                          'Informações pessoais',
                          style: TextStyle(fontSize: 16),
                        ),
                        FormInputBox(
                          hintText: 'Nome Completo',
                          controller: _nameController,
                          validator: (String? val) {
                            if (GetUtils.isLengthLessOrEqual(val, 3)) {
                              return "Insira o nome completo.";
                            }
                            return null;
                          },
                        ),
                        FormInputBox(
                          hintText: 'Telefone (com DDD)',
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
                            if (!GetUtils.isEmail(val!)) {
                              return "Insira um e-mail válido.";
                            }
                            return null;
                          },
                        ),
                        FormInputBoxPassword(
                          hintText: 'Senha',
                          controller: _pwController,
                          validator: (String? val) {
                            if (val == null) {
                              return 'Senha inválida.';
                            }
                            var passwordValidation = val.isValidPassword;
                            if (passwordValidation.isNotEmpty) {
                              return passwordValidation.toString();
                            }
                            return null;
                          },
                        ),
                        FormInputBoxPassword(
                          hintText: 'Confirme sua senha',
                          controller: _pwConfirmationController,
                          validator: (String? val) {
                            if (val == null) {
                              return 'Senha inválida.';
                            }
                            var passwordValidation = val.isValidPassword;
                            if (passwordValidation.isNotEmpty) {
                              return passwordValidation.toString();
                            }
                            return null;
                          },
                        ),
                        Center(
                            child: PrimaryButton(
                                isLoading: isLoading,
                                onTap: _registerUser,
                                text: 'Salvar')),
                        const SizedBox(height: 10),
                        Center(
                            child: PrimaryButton(
                                onTap: () => Get.toNamed(Routes.initialRoute),
                                text: 'Voltar')),
                        const SizedBox(height: 10)
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
