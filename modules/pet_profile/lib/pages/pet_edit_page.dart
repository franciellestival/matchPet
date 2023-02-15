import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/pages/bottom_nav_bar.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:pet_profile/widgets/dialog_links.dart';
import 'package:theme/export_theme.dart';

class PetEditPage extends StatefulWidget {
  static const heightSpacer = HeightSpacer();

  const PetEditPage({super.key});

  @override
  State<PetEditPage> createState() => _PetEditPageState();
}

class _PetEditPageState extends State<PetEditPage> {
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

  final isLoading = false.obs;

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
          ImageInput(
              placeHolderPath: pet.photoUrl!, isEnabled: inputEnabled.value),
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
                        isLoading: isLoading,
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
                          onTap: () => _verifyPetAdopted(),
                          text: 'Editar'),
                      PrimaryButton(
                          width: 170,
                          onTap: () => {_deletePet()},
                          text: 'Excluir',
                          isLoading: isLoading),
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
              PetEditPage.heightSpacer,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildPetRegisterForm(_formKey),
              ),
              PetEditPage.heightSpacer,
            ],
          ),
        ),
      );
    });
  }

  Future<void> _editPet() async {
    if (_formKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        await PetController.updatePet(
            pet.id!,
            _nameController.text,
            speciesCurrentValue.value,
            genderCurrentValue.value,
            sizeCurrentValue.value,
            pet.status!.displayName!,
            _breedController.text,
            int.parse(_ageController.text),
            double.parse(_weightController.text),
            _descriptionController.text,
            neuteredCurrentValue.value == 'Sim' ? true : false,
            specialNeedsCurrentValue.value == 'Sim' ? true : false,
            _imageController.isImagePathSet.value
                ? _imageController.imagePath.value
                : '');

        pet = await PetController.getPetByID(pet.id!) ?? pet;
        Get.dialog(AlertDialog(
          title: const Text("Sucesso!"),
          content: const Text("Os dados do pet foram alterados."),
          actions: [
            GoBackDialogLink(onPressed: () {
              Get.off(() => CustomBottomNavBar(selectedIndex: 4));
            }),
          ],
          backgroundColor: AppColors.primaryLightColor,
        ));
      } catch (e) {
        Get.dialog(AlertDialog(
          title: const Text("Erro!"),
          content: const Text("Não foi possível alterar os dados do Pet."),
          actions: [
            GoBackDialogLink(onPressed: () {
              Get.back();
            }),
          ],
          backgroundColor: AppColors.primaryLightColor,
        ));
      }
      inputEnabled.value = false;
      isLoading.value = false;
    }
  }

  Future<void> _deletePet() async {
    inputEnabled.value = false;
    Get.dialog(AlertDialog(
      title: const Text("Atenção!"),
      content: const Text("Deseja realmente remover o pet?"),
      actions: [
        ContinueDialogLink(onPressed: () async {
          isLoading.value = true;
          try {
            await PetController.deletePet(pet.id!);

            Get.dialog(AlertDialog(
              title: const Text("Sucesso!"),
              content: const Text("O pet foi removido com sucesso!"),
              actions: [
                GoBackDialogLink(onPressed: () {
                  Get.back(closeOverlays: true);
                  Get.off(() => CustomBottomNavBar(selectedIndex: 4));
                }),
              ],
              backgroundColor: AppColors.primaryLightColor,
            ));
          } catch (e) {
            Get.dialog(AlertDialog(
              title: const Text("Erro!"),
              content: const Text("Não foi possível remover o pet."),
              actions: [
                GoBackDialogLink(onPressed: () {
                  Get.back();
                }),
              ],
              backgroundColor: AppColors.primaryLightColor,
            ));
          }
          isLoading.value = false;
        }),
        GoBackDialogLink(onPressed: () {
          Get.back();
        }),
      ],
      backgroundColor: AppColors.primaryLightColor,
    ));
  }

  void _verifyPetAdopted() async {
    if (await PetController.isPetAdopted(pet)) {
      inputEnabled.value = false;
      Get.dialog(
        AlertDialog(
          title: const Text("Ops!"),
          content: const Text(
              "Este pet já foi adotado. Não é possível editar suas informações."),
          actions: [
            GoBackDialogLink(onPressed: () {
              Get.back();
            })
          ],
          backgroundColor: AppColors.primaryLightColor,
        ),
      );
    } else {
      inputEnabled.value = true;
    }
  }
}
