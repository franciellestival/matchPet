import 'dart:io';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/svg.dart';
import 'package:theme/components/button_component.dart';

import 'package:theme/components/form_components.dart';
import 'package:theme/components/image_form_field.dart';
import 'package:theme/components/spacer.dart';
import 'package:theme/layout/app_assets.dart';
import 'package:theme/layout/app_config.dart';
import 'package:image_form_field/image_form_field.dart';

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
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            heightSpacer,
            const Text(
              'Cadastro de Pet',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            heightSpacer,
            Center(
              child: SvgPicture.asset(
                AppSvgs.appIcon,
                height: 100,
                width: 100,
              ),
            ),
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
        ImageFormField<ImageInputAdapter>(
            //previewImageBuilder: (_, ImageInputAdapter image) => image.widgetize(),
            buttonBuilder: (_, int count) => Container(
                child: Text(count == null || count < 1
                    ? "Upload Image"
                    : "Upload More"))
            //initializeFileAsImage: (File file) => ImageInputAdapter(file: file),
            //initialValue: existingPhotoUrl == null ? null : (List<ImageInputImageAdapter>()..add(ImageInputImageAdapter(url: existingPhotoUrl))),
            // Even if `shouldAllowMultiple` is true, images will always be a `List` of the declared type (i.e. `ImageInputAdater`).
            //onSaved: (images) _images = images,
            ),
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
