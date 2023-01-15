import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/models/pet_profile.dart';

import 'package:theme/export_theme.dart';

class PetProfilePage extends StatefulWidget {
  static const heightSpacer = HeightSpacer();

  const PetProfilePage({super.key});

  @override
  State<PetProfilePage> createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage> {
  //formKey set up
  final _formKey = GlobalKey<FormState>();
  PetProfile pet = Get.arguments;

  //controllers setup
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _speciesController = TextEditingController();
  final _genderController = TextEditingController();
  final _sizeController = TextEditingController();
  final _statusController = TextEditingController();
  final _neuteredController = TextEditingController();
  final _specialNeeds = TextEditingController();
  Rx<bool> inputEnabled = Rx<bool>(false);

  //DropDown menu and values set up
  final List<String> neutered = ['Sim', 'Não'];
  Rx<String> neuteredCurrentValue = ''.obs;

  final List<String> specialNeeds = ['Sim', 'Não'];
  Rx<String> specialNeedsCurrentValue = ''.obs;

  Form _buildPetRegisterForm(GlobalKey<FormState> formKey) {
    //controllers setup
    _nameController.text = pet.name ?? '';
    _locationController.text = pet.location?.address ?? '';
    _breedController.text = pet.breed ?? '';
    _ageController.text = pet.age?.toString() ?? '';
    _weightController.text = pet.weight?.toString() ?? '';
    _descriptionController.text = pet.description ?? '';
    _genderController.text = pet.gender?.displayName ?? '';
    _sizeController.text = pet.size?.displayName ?? '';
    _neuteredController.text = pet.neutered ?? false ? 'Sim' : 'Não';
    _statusController.text = pet.status?.displayName ?? '';
    _specialNeeds.text = pet.specialNeeds ?? false ? 'Sim' : 'Não';

    Rx<String> speciesCurrentValue = ''.obs;
    Rx<String> genderCurrentValue = ''.obs;
    Rx<String> sizeCurrentValue = ''.obs;
    Rx<String> statusCurrentValue = ''.obs;

    return Form(
      key: formKey,
      child: Wrap(
        runSpacing: 22,
        children: <Widget>[
          const Text(
            'Informações Gerais',
            style: TextStyle(fontSize: 16),
          ),
          FormInputBox(
            backgroundColor: inputBackgoundColor(),
            enable: inputEnabled.value,
            hintText: 'Nome',
            controller: _nameController,
          ),
          inputEnabled.value
              ? FutureBuilder<List<String?>>(
                  future: PetController.species(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!;
                      return FormDropDownInput(
                          child: DropDownItem(
                        items: data,
                        currentValue: speciesCurrentValue,
                        hintText: 'Espécie',
                      ));
                    } else {
                      if (snapshot.hasError) {
                        Get.snackbar('Error', snapshot.error.toString());
                      }
                      return const CircularProgressIndicator();
                    }
                  },
                )
              : FormInputBox(
                  backgroundColor: inputBackgoundColor(),
                  enable: false,
                  hintText: 'Espécie',
                  controller: _speciesController,
                ),
          inputEnabled.value
              ? FutureBuilder<List<String?>>(
                  future: PetController.genders(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!;
                      return FormDropDownInput(
                          child: DropDownItem(
                        items: data,
                        currentValue: genderCurrentValue,
                        hintText: 'Sexo',
                      ));
                    } else {
                      if (snapshot.hasError) {
                        Get.snackbar('Error', snapshot.error.toString());
                      }
                      return const CircularProgressIndicator();
                    }
                  },
                )
              : FormInputBox(
                  backgroundColor: inputBackgoundColor(),
                  enable: false,
                  hintText: 'Sexo',
                  controller: _genderController,
                ),
          inputEnabled.value
              ? FutureBuilder<List<String?>>(
                  future: PetController.sizes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!;
                      return FormDropDownInput(
                          child: DropDownItem(
                        items: data,
                        currentValue: sizeCurrentValue,
                        hintText: 'Porte',
                      ));
                    } else {
                      if (snapshot.hasError) {
                        Get.snackbar('Error', snapshot.error.toString());
                      }
                      return const CircularProgressIndicator();
                    }
                  },
                )
              : FormInputBox(
                  backgroundColor: inputBackgoundColor(),
                  enable: false,
                  hintText: 'Porte',
                  controller: _sizeController,
                ),
          inputEnabled.value
              ? FutureBuilder<List<String?>>(
                  future: PetController.status(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!;
                      return FormDropDownInput(
                          child: DropDownItem(
                        items: data,
                        currentValue: statusCurrentValue,
                        hintText: 'Status',
                      ));
                    } else {
                      if (snapshot.hasError) {
                        Get.snackbar('Error', snapshot.error.toString());
                      }
                      return const CircularProgressIndicator();
                    }
                  },
                )
              : FormInputBox(
                  backgroundColor: inputBackgoundColor(),
                  enable: false,
                  hintText: 'Status',
                  controller: _statusController,
                ),
          inputEnabled.value
              ? FormDropDownInput(
                  child: DropDownItem(
                    currentValue: neuteredCurrentValue,
                    items: neutered,
                    hintText: 'Castrado(a)?',
                  ),
                )
              : FormInputBox(
                  backgroundColor: inputBackgoundColor(),
                  enable: false,
                  hintText: 'Castrado(a)',
                  controller: _neuteredController,
                ),
          inputEnabled.value
              ? FormDropDownInput(
                  child: DropDownItem(
                    currentValue: specialNeedsCurrentValue,
                    items: specialNeeds,
                    hintText: 'Necessidades Especiais?',
                  ),
                )
              : FormInputBox(
                  backgroundColor: inputBackgoundColor(),
                  enable: false,
                  hintText: 'Necessidades Especiais',
                  controller: _specialNeeds,
                ),
          FormInputBox(
            backgroundColor: inputBackgoundColor(),
            enable: inputEnabled.value,
            hintText: 'Localização',
            controller: _locationController,
          ),
          FormInputBox(
            backgroundColor: inputBackgoundColor(),
            enable: inputEnabled.value,
            hintText: 'Raça',
            controller: _breedController,
          ),
          FormInputBox(
            backgroundColor: inputBackgoundColor(),
            enable: inputEnabled.value,
            hintText: 'Idade',
            controller: _ageController,
            textInputType: TextInputType.number,
          ),
          FormInputBox(
            backgroundColor: inputBackgoundColor(),
            enable: inputEnabled.value,
            hintText: 'Peso',
            controller: _weightController,
            textInputType: TextInputType.number,
          ),
          FormInputBox(
            backgroundColor: inputBackgoundColor(),
            enable: inputEnabled.value,
            hintText: 'Descrição',
            controller: _descriptionController,
          ),
          Center(
            child: inputEnabled.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryButton(
                        width: 170,
                        onTap: () => {},
                        text: 'Salvar',
                      ),
                      PrimaryButton(
                        width: 170,
                        onTap: () => {inputEnabled.value = false},
                        text: 'Cancelar',
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryButton(
                          width: 170,
                          onTap: () => {inputEnabled.value = true},
                          text: 'Editar'),
                      PrimaryButton(
                          width: 170, onTap: () => {}, text: 'Excluir'),
                    ],
                  ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const GenericAppBar(title: 'Editar Pet'),
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              PetProfilePage.heightSpacer,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildPetRegisterForm(_formKey),
              ),
              PetProfilePage.heightSpacer,
            ],
          ),
        ),
      );
    });
  }

  Color? inputBackgoundColor() {
    return inputEnabled.value ? null : Colors.grey.withOpacity(0.5);
  }
}
