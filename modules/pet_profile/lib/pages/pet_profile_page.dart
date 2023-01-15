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
  PetProfile pet = Get.arguments;

  //formKey set up
  final _formKey = GlobalKey<FormState>();

  //controllers setup
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _imageController = Get.put<ImageController>(ImageController());
  // Rx<bool> inputEnabled = Rx<bool>(false);
  final inputEnabled = false.obs;

  Rx<String> speciesCurrentValue = ''.obs;
  Rx<String> genderCurrentValue = ''.obs;
  Rx<String> sizeCurrentValue = ''.obs;
  Rx<String> statusCurrentValue = ''.obs;

  final List<String> neutered = ['Sim', 'Não'];
  Rx<String> neuteredCurrentValue = ''.obs;

  final List<String> specialNeeds = ['Sim', 'Não'];
  Rx<String> specialNeedsCurrentValue = ''.obs;

  Form _buildPetRegisterForm(GlobalKey<FormState> formKey) {
    _nameController.text = pet.name!;
    speciesCurrentValue.value = pet.specie!.displayName!;
    genderCurrentValue.value = pet.gender!.displayName!;
    sizeCurrentValue.value = pet.size!.displayName!;
    statusCurrentValue.value = pet.status!.displayName!;
    _breedController.text = pet.breed!;
    _ageController.text = pet.age!.toString();
    _weightController.text = pet.weight!.toString();
    _descriptionController.text = pet.description!;
    neuteredCurrentValue.value = pet.neutered! ? 'Sim' : 'Não';
    specialNeedsCurrentValue.value = pet.specialNeeds! ? 'Sim' : 'Não';
    _imageController.setImageURL(pet.photoUrl!);
    _imageController.unsetImagePath();

    return Form(
      key: formKey,
      child: Wrap(
        runSpacing: 22,
        children: <Widget>[
          // ImageInput(placeHolderPath: AppSvgs.pawIcon),
          ImageInput(placeHolderPath: pet.photoUrl!, isEnabled: inputEnabled),
          const Text(
            'Informações Gerais',
            style: TextStyle(fontSize: 16),
          ),
          FormInputBox(
            hintText: 'Nome',
            controller: _nameController,
            enable: inputEnabled.value,
            backgroundColor:
                inputEnabled.value ? null : Colors.grey.withOpacity(0.5),
          ),
          FutureBuilder<List<String?>>(
            future: PetController.species(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return FormDropDownInput(
                    backgroundColor: inputEnabled.value
                        ? null
                        : Colors.grey.withOpacity(0.5),
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
                    backgroundColor: inputEnabled.value
                        ? null
                        : Colors.grey.withOpacity(0.5),
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
                    backgroundColor: inputEnabled.value
                        ? null
                        : Colors.grey.withOpacity(0.5),
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
            future: PetController.status(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return FormDropDownInput(
                    backgroundColor: inputEnabled.value
                        ? null
                        : Colors.grey.withOpacity(0.5),
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
            backgroundColor:
                inputEnabled.value ? null : Colors.grey.withOpacity(0.5),
            child: DropDownItem(
                currentValue: neuteredCurrentValue,
                items: neutered,
                hintText: 'Castrado(a)?',
                isEnabled: inputEnabled),
          ),
          FormDropDownInput(
            backgroundColor:
                inputEnabled.value ? null : Colors.grey.withOpacity(0.5),
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
            backgroundColor:
                inputEnabled.value ? null : Colors.grey.withOpacity(0.5),
          ),
          FormInputBox(
            hintText: 'Idade',
            controller: _ageController,
            textInputType: TextInputType.number,
            enable: inputEnabled.value,
            backgroundColor:
                inputEnabled.value ? null : Colors.grey.withOpacity(0.5),
          ),
          FormInputBox(
            hintText: 'Peso',
            controller: _weightController,
            textInputType: TextInputType.number,
            enable: inputEnabled.value,
            backgroundColor:
                inputEnabled.value ? null : Colors.grey.withOpacity(0.5),
          ),
          FormInputBox(
            hintText: 'Descrição',
            controller: _descriptionController,
            enable: inputEnabled.value,
            backgroundColor:
                inputEnabled.value ? null : Colors.grey.withOpacity(0.5),
          ),
          Center(
            child: inputEnabled.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryButton(
                        width: 170,
                        onTap: () => {_editPet()},
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
                          width: 170,
                          onTap: () => {_deletePet()},
                          text: 'Excluir'),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const GenericAppBar(title: 'Cadastrar Pet'),
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

  Future<void> _editPet() async {
    if (_formKey.currentState!.validate()) {
      try {
        await PetController.updatePet(
            pet.id!,
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
            _imageController.isImagePathSet.value
                ? _imageController.imagePath.value
                : '');

        Get.snackbar("Sucesso!", "Pet alterado com sucesso!");
      } catch (e) {
        Get.snackbar("Erro!", e.toString(),
            duration: const Duration(seconds: 5));
      }
      inputEnabled.value = false;
    }
  }

  Future<void> _deletePet() async {
    inputEnabled.value = false;
    Get.defaultDialog(
      title: "Atenção!",
      middleText: "Deseja realmente remover o pet?",
      textCancel: "Cancelar",
      textConfirm: "Remover",
      backgroundColor: AppColors.primaryLightColor,
      buttonColor: AppColors.buttonColor,
      barrierDismissible: false,
      cancelTextColor: AppColors.black,
      confirmTextColor: AppColors.black,
      onConfirm: () {
        try {
          //TODO Desabilitado para testes
          //TODO PetContoller.deletePet(pet.id);
          Get.offAndToNamed(Routes.initialRoute);
        } catch (e) {
          Get.snackbar("Erro!", e.toString(),
              duration: const Duration(seconds: 5));
        }
      },
    );
  }
}
