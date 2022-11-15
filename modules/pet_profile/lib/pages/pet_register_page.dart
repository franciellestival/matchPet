import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/model/new_pet.dart';

import 'package:theme/export_theme.dart';

class PetRegisterPage extends StatefulWidget {
  static const heightSpacer = HeightSpacer();

  PetRegisterPage({super.key});

  @override
  State<PetRegisterPage> createState() => _PetRegisterPageState();
}

class _PetRegisterPageState extends State<PetRegisterPage> {
  //formKey set up
  final _formKey = GlobalKey<FormState>();

  //controllers setup
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _descriptionController = TextEditingController();

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
          ImageInput(ontapIcon: () {}, placeHolderPath: AppSvgs.pawIcon),
          const Text(
            'Informações Gerais',
            style: TextStyle(fontSize: 16),
          ),
          FormInputBox(hintText: 'Nome', controller: _nameController),
          FormDropDownInput(
            child: buildDropDownItem(
                currentValue: speciesCurrentValue,
                items: species,
                hintText: 'Espécie'),
          ),
          FormDropDownInput(
            child: buildDropDownItem(
                currentValue: genderCurrentValue,
                items: gender,
                hintText: 'Sexo'),
          ),
          FormDropDownInput(
            child: buildDropDownItem(
                currentValue: sizeCurrentValue, items: size, hintText: 'Porte'),
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
                hintText: 'Castrado(a)?'),
          ),
          FormDropDownInput(
            child: buildDropDownItem(
                currentValue: specialNeedsCurrentValue,
                items: specialNeeds,
                hintText: 'Necessidades Especiais?'),
          ),
          FormInputBox(
              hintText: 'Localização', controller: _locationController),
          FormInputBox(hintText: 'Raça', controller: _breedController),
          FormInputBox(hintText: 'Idade', controller: _ageController),
          FormInputBox(hintText: 'Peso', controller: _weightController),
          FormInputBox(
              hintText: 'Descrição', controller: _descriptionController),
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
            PetRegisterPage.heightSpacer,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildPetRegisterForm(_formKey),
            ),
            PetRegisterPage.heightSpacer,
            PrimaryButton(onTap: _registerPet, text: 'Salvar'),
            PetRegisterPage.heightSpacer
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
    Size size = Size.values.first;
    Status status = Status.registered;
    Species species = Species.other;

    switch (sizeCurrentValue.value) {
      case 'Pequeno':
        size = Size.small;
        break;
      case 'Medio':
        size = Size.medium;
        break;
      case 'Grande':
        size = Size.big;
        break;
    }

    switch (sizeCurrentValue.value) {
      case 'Disponível':
        status = Status.available;
        break;
      case 'Desaparecido':
        status = Status.missing;
        break;
      default:
        status = Status.registered;
        break;
    }

    switch (speciesCurrentValue.value) {
      case 'Cão':
        species = Species.dog;
        break;
      case 'Gato':
        species = Species.cat;
        break;
      default:
        species = Species.other;
        break;
    }

    final petToRegister = NewPet(
      name: _nameController.text,
      breed: _breedController.text,
      description: _descriptionController.text,
      age: int.parse(_ageController.text),
      neutered: neuteredCurrentValue.value.contains('Não') ? 0 : 1,
      specialNeeds: specialNeedsCurrentValue.value.contains('Não') ? 0 : 1,
      gender: genderCurrentValue.value.contains('Macho')
          ? Gender.male
          : Gender.female,
      size: size,
      status: status,
      species: species,
      weight: double.parse(_weightController.text),
    );
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
