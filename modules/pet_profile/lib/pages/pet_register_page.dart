import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/pages/bottom_nav_bar.dart';
import 'package:pet_profile/controller/pet_controller.dart';

import 'package:theme/export_theme.dart';

import '../widgets/dialog_links.dart';

class PetRegisterPage extends StatefulWidget {
  static const heightSpacer = HeightSpacer();

  const PetRegisterPage({super.key});

  @override
  State<PetRegisterPage> createState() => _PetRegisterPageState();
}

class _PetRegisterPageState extends State<PetRegisterPage> {
  //formKey set up
  final _formKey = GlobalKey<FormState>();

  //controllers setup
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _descriptionController = TextEditingController();

  final ImageController _imageController =
      Get.put<ImageController>(ImageController());

  Rx<String> speciesCurrentValue = ''.obs;
  Rx<String> genderCurrentValue = ''.obs;
  Rx<String> sizeCurrentValue = ''.obs;
  Rx<String> statusCurrentValue = ''.obs;

  final List<String> neutered = ['Sim', 'Não'];
  Rx<String> neuteredCurrentValue = ''.obs;

  final List<String> specialNeeds = ['Sim', 'Não'];
  Rx<String> specialNeedsCurrentValue = ''.obs;

  final inputEnabled = true.obs;
  final isLoading = false.obs;

  Form _buildPetRegisterForm(GlobalKey<FormState> formKey) {
    return Form(
      key: formKey,
      child: Wrap(
        runSpacing: 22,
        children: <Widget>[
          ImageInput(placeHolderPath: AppSvgs.pawIcon, isEnabled: true),
          const Text(
            'Informações Gerais',
            style: TextStyle(fontSize: 16),
          ),
          FormInputBox(
            hintText: 'Nome',
            controller: _nameController,
            enable: inputEnabled.value,
            validator: (String? val) {
              if (GetUtils.isLengthLessOrEqual(val, 3)) {
                return "Insira o nome do pet.";
              }
              return null;
            },
          ),
          FutureBuilder<List<String?>>(
            future: PetController.species(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return FormDropDownInput(
                    child: DropDownItem(
                  items: data,
                  currentValue: speciesCurrentValue,
                  hintText: 'Espécie',
                  isEnabled: inputEnabled,
                ));
              } else {
                if (snapshot.hasError) {
                  Get.snackbar('Error', snapshot.error.toString());
                }
                return const CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<List<String?>>(
            future: PetController.genders(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return FormDropDownInput(
                    child: DropDownItem(
                  items: data,
                  currentValue: genderCurrentValue,
                  hintText: 'Sexo',
                  isEnabled: inputEnabled,
                ));
              } else {
                if (snapshot.hasError) {
                  Get.snackbar('Error', snapshot.error.toString());
                }
                return const CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<List<String?>>(
            future: PetController.sizes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return FormDropDownInput(
                    child: DropDownItem(
                  items: data,
                  currentValue: sizeCurrentValue,
                  hintText: 'Porte',
                  isEnabled: inputEnabled,
                ));
              } else {
                if (snapshot.hasError) {
                  Get.snackbar('Error', snapshot.error.toString());
                }
                return const CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<List<String?>>(
            future: PetController.status(only: ['available', 'missing']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return FormDropDownInput(
                    child: DropDownItem(
                  items: data,
                  currentValue: statusCurrentValue,
                  hintText: 'Status',
                  isEnabled: inputEnabled,
                ));
              } else {
                if (snapshot.hasError) {
                  Get.snackbar('Error', snapshot.error.toString());
                }
                return const CircularProgressIndicator();
              }
            },
          ),
          FormDropDownInput(
            child: DropDownItem(
              currentValue: neuteredCurrentValue,
              items: neutered,
              hintText: 'Castrado(a)?',
              isEnabled: inputEnabled,
            ),
          ),
          FormDropDownInput(
            child: DropDownItem(
              currentValue: specialNeedsCurrentValue,
              items: specialNeeds,
              hintText: 'Necessidades Especiais?',
              isEnabled: inputEnabled,
            ),
          ),
          FormInputBox(
            hintText: 'Raça',
            controller: _breedController,
            enable: inputEnabled.value,
            validator: (String? val) {
              if (GetUtils.isLengthLessOrEqual(val, 3)) {
                return "Insira a raça do pet";
              }
              return null;
            },
          ),
          FormInputBox(
            hintText: 'Idade (em anos)',
            controller: _ageController,
            textInputType: TextInputType.number,
            enable: inputEnabled.value,
            validator: (String? val) {
              if (GetUtils.isNullOrBlank(val) ?? true) {
                return "Insira a idade do pet";
              } else if (!GetUtils.isNum(val!)) {
                return "Insira um número válido";
              } else {
                return null;
              }
            },
          ),
          FormInputBox(
            hintText: 'Peso (em kg)',
            controller: _weightController,
            textInputType: TextInputType.number,
            enable: inputEnabled.value,
            validator: (String? val) {
              if (GetUtils.isNullOrBlank(val) ?? true) {
                return "Insira o peso do pet";
              } else if (!GetUtils.isNum(val!)) {
                return "Insira um número válido";
              } else {
                return null;
              }
            },
          ),
          FormInputBox(
            hintText: 'Descrição',
            controller: _descriptionController,
            enable: inputEnabled.value,
            validator: (String? val) {
              if (GetUtils.isLengthLessOrEqual(val, 3)) {
                return "Insira a descrição do pet";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: 'Cadastrar Pet', showBackArrow: false),
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PetRegisterPage.heightSpacer,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildPetRegisterForm(_formKey),
            ),
            PetRegisterPage.heightSpacer,
            PrimaryButton(
              onTap: _registerPet,
              text: 'Salvar',
              isLoading: isLoading,
            ),
            PetRegisterPage.heightSpacer
          ],
        ),
      ),
    );
  }

  Future<void> _registerPet() async {
    if (_formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await PetController.registerPet(
            _nameController.text,
            speciesCurrentValue.value,
            genderCurrentValue.value,
            sizeCurrentValue.value,
            statusCurrentValue.value,
            _breedController.text,
            int.parse(_ageController.text),
            double.parse(_weightController.text),
            _descriptionController.text,
            neuteredCurrentValue.value == 'Sim' ? true : false,
            specialNeedsCurrentValue.value == 'Sim' ? true : false,
            _imageController.imagePath.value);
        // Get.off(() => CustomBottomNavBar(selectedIndex: 4));
        Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            title: const Text('Sucesso!'),
            content: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 20, color: AppColors.black),
                children: [
                  const TextSpan(text: "Seu pet "),
                  TextSpan(
                    text: _nameController.text,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: " foi cadastrado com sucesso!"),
                ],
              ),
            ),
            actions: [
              ContinueDialogLink(onPressed: () {
                Get.back();
                Get.off(() => CustomBottomNavBar(selectedIndex: 4));
              }),
            ],
          ),
        );
      } on Exception {
        Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            title: const Text('Erro'),
            content: const Text('Ocorreu um erro ao registrar seu Pet!'),
            actions: [
              GoBackDialogLink(onPressed: () {
                Get.back();
              }),
            ],
          ),
        );
      }
      isLoading.value = false;
    }
  }
}
