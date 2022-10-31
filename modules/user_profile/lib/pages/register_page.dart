import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:matchpet_poc/routes/app_routes.dart';
import 'package:matchpet_poc/services/api_user_services.dart';
import 'package:matchpet_poc/extensions/ext_string.dart';
import 'package:theme/components/button_component.dart';
import 'package:theme/components/form_components.dart';
import 'package:theme/layout/app_assets.dart';
import 'package:theme/layout/app_config.dart';
import 'package:theme/layout/appbar.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/model/user_location.dart';

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

  @override
  Widget build(BuildContext context) {
    var phoneFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Scaffold(
      appBar: GenericAppBar(title: 'Cadastro', appBar: AppBar()),
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: SvgPicture.asset(
                      AppSvgs.appIcon,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Cadastro de usuário',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),
                  Form(
                    key: _formKey,
                    child: Wrap(
                      runSpacing: 22,
                      children: <Widget>[
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
                                onTap: _signUpUser, text: 'Salvar')),
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

  //Requisita permissão de acesso para o usuário
  Future<LocationData?> _getUserLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        log("INFO: Serviço de GPS nao ativado.");
        return null;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        log("INFO: Permissão do uso de GPS nao concedida.");
        return null;
      }
    }
    log("INFO: " + _permissionGranted.toString());

    _locationData = await location.getLocation();
    return _locationData;
  }

  //Função de Cadastro do usuário, retornando um User cadastrado e logado
  Future<User?> _signUpUser() async {
    LocationData? _locationData;

    _locationData = await _getUserLocation();

    if (_locationData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro ao requisitar localização")));
      return null;
    }

    if (_formKey.currentState!.validate()) {
      User newUser = User(
          fullName: _nameController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          password: _pwController.text,
          passwordConfirmation: _pwConfirmationController.text,
          location: UserLocation(
              lat: _locationData.latitude,
              lng: _locationData.longitude,
              address: "Rua Teste, 123"));
      try {
        User? user = (await APIUserServices().saveUser(newUser))!;
        if (user != null) {
          Get.offAndToNamed(Routes.STATUS, arguments: newUser);
          return newUser;
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    return null;
  }
}
