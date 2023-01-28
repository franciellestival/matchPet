import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_profile/controller/pet_controller.dart';

import 'package:pet_profile/widgets/pet_card.dart';
import 'package:pet_profile/widgets/pet_list.dart';
import 'package:theme/export_theme.dart';

class MissingPetPage extends StatelessWidget {
  final String listTitle = 'Pets Desaparecidos';

  const MissingPetPage({super.key});

  Future<List<PetCard>?> _getPetsList() async {
    try {
      return await PetController.getFilteredPets({"status": "missing"});
    } catch (e) {
      Get.snackbar(
          'Erro!', "Não foi possivel obter a lista de Animais Desaparecidos.");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: listTitle),
      backgroundColor: AppColors.primaryLightColor,
      body: SingleChildScrollView(
        child: FutureBuilder<List<PetCard>?>(
          future: _getPetsList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PetList(title: listTitle, children: snapshot.data!);
            } else {
              if (snapshot.hasError) {
                Get.snackbar('Error', snapshot.error.toString());
              }
              return const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.buttonColor));
            }
          },
        ),
      ),
    );
  }
}
