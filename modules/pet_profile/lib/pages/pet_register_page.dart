import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/svg.dart';

import 'package:theme/export_theme.dart';

enum Sexo { MACHO, FEMEA }

enum Porte { PEQUENO, MEDIO, GRANDE }

enum Especie { CAO, GATO, PASSARO, ROEDOR, OUTRO }

enum Status { DISPONIVEL, ADOTADO, DESAPARECIDO }

class PetRegisterPage extends StatelessWidget {
  final List<String> sexo = Sexo.values.map((e) => e.toString()).toList();
  final List<String> porte = Porte.values.map((e) => e.toString()).toList();
  final List<String> especie = Especie.values.map((e) => e.toString()).toList();
  final List<String> status = Status.values.map((e) => e.toString()).toList();

  PetRegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Cadastro de Pet',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                AppSvgs.appIcon,
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Wrap(
                  runSpacing: 22,
                  children: <Widget>[
                    const Text(
                      'Informações Gerais',
                      style: TextStyle(fontSize: 16),
                    ),
                    FormInputBox(hintText: 'Nome', controller: controller),
                    FormDropDownInput(items: especie, hintText: 'Espécie'),
                    FormDropDownInput(
                        items: sexo.map((e) => e.toString()).toList(),
                        hintText: 'Sexo'),
                    FormDropDownInput(items: porte, hintText: 'Porte'),
                    FormDropDownInput(items: status, hintText: 'Status'),
                    FormInputBox(
                        hintText: 'Localização', controller: controller),
                    FormInputBox(hintText: 'Raça', controller: controller),
                    FormInputBox(hintText: 'Idade', controller: controller),
                    FormInputBox(hintText: 'Peso', controller: controller),
                    FormInputBox(hintText: 'Descrição', controller: controller),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(onTap: () {}, text: 'Salvar'),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
