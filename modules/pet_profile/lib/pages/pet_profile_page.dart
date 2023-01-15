import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/pet_controller.dart';

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

  //controllers setup
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = Get.put<ImageController>(ImageController());
  Rx<bool> inputEnabled = Rx<bool>(false);

  //DropDown menu and values set up
  late List<String> species;
  Rx<String> speciesCurrentValue = ''.obs;

  late List<String> genders;
  Rx<String> genderCurrentValue = ''.obs;

  late List<String> sizes;
  Rx<String> sizeCurrentValue = ''.obs;

  late List<String> status;
  Rx<String> statusCurrentValue = ''.obs;

  final List<String> neutered = ['Sim', 'Não'];
  Rx<String> neuteredCurrentValue = ''.obs;

  final List<String> specialNeeds = ['Sim', 'Não'];
  Rx<String> specialNeedsCurrentValue = ''.obs;

  Form _buildPetRegisterForm(GlobalKey<FormState> formKey) {
    return Form(
      key: formKey,
      child: Wrap(
        runSpacing: 22,
        children: <Widget>[
          ImageInput(placeHolderPath: AppSvgs.pawIcon),
          const Text(
            'Informações Gerais',
            style: TextStyle(fontSize: 16),
          ),
          FormInputBox(
            hintText: 'Nome',
            controller: _nameController,
          ),
          FormDropDownInput(
            child: DropDownItem(
              currentValue: speciesCurrentValue,
              items: species,
              hintText: 'Espécie',
            ),
          ),
          FormDropDownInput(
            child: DropDownItem(
              currentValue: genderCurrentValue,
              items: genders,
              hintText: 'Sexo',
            ),
          ),
          FormDropDownInput(
            child: DropDownItem(
              currentValue: sizeCurrentValue,
              items: sizes,
              hintText: 'Porte',
            ),
          ),
          FormDropDownInput(
            child: DropDownItem(
                currentValue: statusCurrentValue,
                items: status,
                hintText: 'Status'),
          ),
          FormDropDownInput(
            child: DropDownItem(
              currentValue: neuteredCurrentValue,
              items: neutered,
              hintText: 'Castrado(a)?',
            ),
          ),
          FormDropDownInput(
            child: DropDownItem(
              currentValue: specialNeedsCurrentValue,
              items: specialNeeds,
              hintText: 'Necessidades Especiais?',
            ),
          ),
          FormInputBox(
            hintText: 'Localização',
            controller: _locationController,
          ),
          FormInputBox(
            hintText: 'Raça',
            controller: _breedController,
          ),
          FormInputBox(
            hintText: 'Idade',
            controller: _ageController,
            textInputType: TextInputType.number,
          ),
          FormInputBox(
            hintText: 'Peso',
            controller: _weightController,
            textInputType: TextInputType.number,
          ),
          FormInputBox(
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
            PrimaryButton(onTap: _registerPet, text: 'Salvar'),
            PetProfilePage.heightSpacer
          ],
        ),
      ),
    );
  }

  Future<void> _registerPet() async {
    if (_formKey.currentState!.validate()) {
      try {
        await PetController.registerPet(
            _nameController.text,
            speciesCurrentValue.value,
            genderCurrentValue.value,
            sizeCurrentValue.value,
            statusCurrentValue.value,
            _breedController.text,
            int.parse(_breedController.text),
            double.parse(_weightController.text),
            _descriptionController.text,
            neuteredCurrentValue.value == 'Sim' ? true : false,
            specialNeedsCurrentValue.value == 'Sim' ? true : false,
            _imageController.imagePath.value);
        Get.offAndToNamed(Routes.statusRoute);
      } on Exception catch (e) {
        Get.snackbar("Erro!", e.toString(),
            duration: const Duration(seconds: 5));
      }
    }
  }
}
