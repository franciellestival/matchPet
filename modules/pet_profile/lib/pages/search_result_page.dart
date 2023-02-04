import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/pet_controller.dart';

import 'package:pet_profile/widgets/pet_card.dart';
import 'package:pet_profile/widgets/pet_list.dart';
import 'package:theme/export_theme.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  Future<List<PetCard>?>? _petList;

  @override
  void initState() {
    super.initState();
    _petList = _getPetsList();
  }

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
    var listTitle = 'Buscar Pets';
    return Scaffold(
      appBar: GenericAppBar(title: listTitle, showBackArrow: false),
      backgroundColor: AppColors.primaryLightColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeightSpacer(),
            FutureBuilder<List<PetCard>?>(
              future: _petList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
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
                          : Column(
                              children: [
                                Text(
                                  '(${snapshot.data?.length ?? 0}) resultado(s) para a busca',
                                  style: TextStyle(fontSize: 20),
                                ),
                                PetList(
                                    title: listTitle, children: snapshot.data!),
                                const HeightSpacer(),
                                PrimaryButton(
                                    onTap: () {
                                      Get.toNamed(Routes.home);
                                    },
                                    text: 'Voltar'),
                                const HeightSpacer()
                              ],
                            ),
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
