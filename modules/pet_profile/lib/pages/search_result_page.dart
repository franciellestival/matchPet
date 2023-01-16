import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_profile/controller/pet_controller.dart';

import 'package:pet_profile/widgets/pet_card.dart';
import 'package:pet_profile/widgets/pet_list.dart';
import 'package:theme/export_theme.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({super.key});

  var listTitle = 'Buscar Pets';

  Future<List<PetCard>?> _getPetsList() async {
    Map<String, dynamic> arguments = Get.arguments;

    try {
      return await PetController.getFilteredPets(arguments);
    } catch (e) {
      Get.snackbar('Erro!', "Não foi possivel obter a lista de Animais.");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: listTitle),
      backgroundColor: AppColors.primaryLightColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeightSpacer(),
            FutureBuilder<List<PetCard>?>(
              future: _getPetsList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const Text(
                        'Resultado da busca',
                        style: TextStyle(fontSize: 20),
                      ),
                      snapshot.data!.isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  const Text(
                                      'Não houve resultados para a sua pesquisa :('),
                                  const HeightSpacer(),
                                  PrimaryButton(
                                      onTap: () {
                                        Get.back();
                                      },
                                      text: 'Voltar')
                                ],
                              ),
                            )
                          : PetList(title: listTitle, children: snapshot.data!),
                    ],
                  );
                } else {
                  if (snapshot.hasError) {
                    Get.snackbar('Error', snapshot.error.toString());
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.buttonColor));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
