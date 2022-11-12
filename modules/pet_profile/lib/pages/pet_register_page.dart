import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:theme/export_theme.dart';

enum Sexo { MACHO, FEMEA }

enum Porte { PEQUENO, MEDIO, GRANDE }

enum Especie { CAO, GATO, PASSARO, ROEDOR, OUTRO }

enum Status { DISPONIVEL, ADOTADO, DESAPARECIDO }

class PetRegisterPage extends StatelessWidget {
  static const heightSpacer = HeightSpacer();

  PetRegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: 'Cadastrar Pet'),
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            heightSpacer,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildPetRegisterForm(_formKey),
            ),
            heightSpacer,
            PrimaryButton(onTap: () {}, text: 'Salvar'),
            heightSpacer
          ],
        ),
      ),
    );
  }
}

Form _buildPetRegisterForm(GlobalKey<FormState> formKey) {
  final List<String> sexo = Sexo.values.map((e) => e.toString()).toList();
  final List<String> porte = Porte.values.map((e) => e.toString()).toList();
  final List<String> especie = Especie.values.map((e) => e.toString()).toList();
  final List<String> status = Status.values.map((e) => e.toString()).toList();

  final controller = TextEditingController();

  return Form(
    key: formKey,
    child: Wrap(
      runSpacing: 22,
      children: <Widget>[
        ImageInput(ontapIcon: () {}, placeHolderPath: AppSvgs.pawIcon),
        const Text(
          'Informações Gerais',
          style: TextStyle(fontSize: 16),
        ),
        FormInputBox(hintText: 'Nome', controller: controller),
        FormDropDownInput(items: especie, hintText: 'Espécie'),
        FormDropDownInput(items: sexo, hintText: 'Sexo'),
        FormDropDownInput(items: porte, hintText: 'Porte'),
        FormDropDownInput(items: status, hintText: 'Status'),
        FormInputBox(hintText: 'Localização', controller: controller),
        FormInputBox(hintText: 'Raça', controller: controller),
        FormInputBox(hintText: 'Idade', controller: controller),
        FormInputBox(hintText: 'Peso', controller: controller),
        FormInputBox(hintText: 'Descrição', controller: controller),
      ],
    ),
  );
}
