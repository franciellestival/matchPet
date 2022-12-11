import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/pet_controller.dart';

import 'package:theme/export_theme.dart';

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
            int.parse(_ageController.text),
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
