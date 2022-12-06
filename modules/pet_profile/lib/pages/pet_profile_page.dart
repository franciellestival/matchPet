import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/model/new_pet.dart';

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
  final List<String> gender = ['Macho', 'Fêmea'];
  Rx<String> genderCurrentValue = ''.obs;
  final List<String> size = ['Pequeno', 'Médio', 'Grande'];
  Rx<String> sizeCurrentValue = ''.obs;
  final List<String> status = ['Disponível', 'Desaparecido', 'Outro'];
  Rx<String> statusCurrentValue = ''.obs;
  final List<String> species = ['Cão', 'Gato', 'Outro'];
  Rx<String> speciesCurrentValue = ''.obs;
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
            child: buildDropDownItem(
              currentValue: speciesCurrentValue,
              items: species,
              hintText: 'Espécie',
            ),
          ),
          FormDropDownInput(
            child: buildDropDownItem(
              currentValue: genderCurrentValue,
              items: gender,
              hintText: 'Sexo',
            ),
          ),
          FormDropDownInput(
            child: buildDropDownItem(
              currentValue: sizeCurrentValue,
              items: size,
              hintText: 'Porte',
            ),
          ),
          FormDropDownInput(
            child: buildDropDownItem(
                currentValue: statusCurrentValue,
                items: status,
                hintText: 'Status'),
          ),
          FormDropDownInput(
            child: buildDropDownItem(
              currentValue: neuteredCurrentValue,
              items: neutered,
              hintText: 'Castrado(a)?',
            ),
          ),
          FormDropDownInput(
            child: buildDropDownItem(
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

  Widget buildDropDownItem(
      {required Rx<String> currentValue,
      required String hintText,
      required List<String> items}) {
    return DropdownButtonFormField(
      hint: Text(
        hintText,
        style: TextStyle(color: Colors.black.withOpacity(0.3)),
      ),
      dropdownColor: AppColors.editTextColor,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item.toString().split('.').last),
        );
      }).toList(),
      onChanged: (newValue) => setState(() => currentValue.value = newValue!),
    );
  }

  NewPet petInstance() {
    int size = 0;
    var status = 0;
    var species = 0;

    switch (sizeCurrentValue.value) {
      case 'Pequeno':
        size = 1;
        break;
      case 'Médio':
        size = 2;
        break;
      case 'Grande':
        size = 3;
        break;
    }

    switch (sizeCurrentValue.value) {
      case 'Disponível':
        status = 2;
        break;
      case 'Desaparecido':
        status = 4;
        break;
      default:
        status = 1;
        break;
    }

    switch (speciesCurrentValue.value) {
      case 'Cão':
        species = 1;
        break;
      case 'Gato':
        species = 2;
        break;
      default:
        species = 3;
        break;
    }

    final petToRegister = NewPet(
        name: _nameController.text,
        species: species,
        gender: genderCurrentValue.value.contains('Macho') ? 1 : 2,
        size: size,
        status: status,
        breed: _breedController.text,
        age: int.parse(_ageController.text),
        weight: double.parse(_weightController.text),
        description: _descriptionController.text,
        neutered: neuteredCurrentValue.value.contains('Não') ? 0 : 1,
        specialNeeds: specialNeedsCurrentValue.value.contains('Não') ? 0 : 1,
        lat: 0.0,
        lng: 0.0,
        address: 'Rua Fake');
    return petToRegister;
  }

  Future<void> _registerPet() async {
    if (_formKey.currentState!.validate()) {
      final petToRegister = petInstance();
      PetController.registerPet(petToRegister);
      Get.offAndToNamed(Routes.statusRoute);
    } else {
      print('deu ruim tio');
    }
  }
}
