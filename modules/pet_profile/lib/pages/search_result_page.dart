import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/widgets/dialog_links.dart';
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

  Map<String, dynamic> arguments = Get.arguments;

  Future<List<PetCard>?> _getPetsList() async {
    try {
      return await PetController.getFilteredPets(arguments);
    } catch (e) {
      Get.dialog(AlertDialog(
        title: const Text("Erro!"),
        content: const Text("Ocorreu um erro ao exibir Pets cadastrados."),
        backgroundColor: AppColors.primaryLightColor,
        actions: [
          GoBackDialogLink(onPressed: () {
            Get.back();
          })
        ],
      ));
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
                  if (!arguments.containsValue("adopted")) {
                    snapshot.data!.removeWhere(
                        (card) => card.pet.status?.normalizedName == "adopted");
                  }
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '(${snapshot.data?.length ?? 0}) Pet(s) encontrado(s)',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    PrimaryButton(
                                      onTap: () {
                                        Get.offAndToNamed(Routes.home);
                                      },
                                      text: 'Voltar',
                                      width: 150,
                                      height: 50,
                                    ),
                                  ],
                                ),
                                PetList(
                                    title: listTitle, children: snapshot.data!),
                                const HeightSpacer(),
                                const HeightSpacer()
                              ],
                            ),
                    ],
                  );
                } else {
                  if (snapshot.hasError) {
                    Get.dialog(AlertDialog(
                      title: const Text("Erro!"),
                      content: const Text(
                          "Ocorreu um erro ao exibir Pets cadastrados."),
                      backgroundColor: AppColors.primaryLightColor,
                      actions: [
                        GoBackDialogLink(onPressed: () {
                          Get.back();
                        })
                      ],
                    ));
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
