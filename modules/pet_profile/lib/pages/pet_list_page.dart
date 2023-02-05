import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/pages/pet_filter_modal.dart';
import 'package:pet_profile/widgets/dialog_links.dart';

import 'package:pet_profile/widgets/pet_card.dart';
import 'package:pet_profile/widgets/pet_list.dart';
import 'package:theme/export_theme.dart';
import 'package:user_profile/model/user_location.dart';
import 'package:user_profile/repository/user_repository.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({super.key});

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  final String listTitle = 'Todos os Pets';
  Future<List<PetCard>?>? _petList;

  @override
  void initState() {
    super.initState();
    _petList = _getPetsList();
  }

  Future<List<PetCard>?> _getPetsList() async {
    try {
      UserLocation? location = await _getUserLocation();
      if (location != null) {
        return await PetController.getFilteredPets(
            {"distance": 10, "lat": location.lat, "lng": location.lng});
      } else {
        return await PetController.getAllPets();
      }
    } catch (e) {
      _showErrorSnackbar();
      return null;
    }
  }

  Future<UserLocation?> _getUserLocation() async {
    try {
      UserRepository userRepository = Get.find<UserRepository>();
      return await userRepository.getCurrentLocation();
    } catch (e) {
      _showErrorSnackbar();
      return null;
    }
  }

  void _showErrorSnackbar() {
    Get.snackbar(
      'Erro!',
      'Não foi possível obter a lista de Animais.',
    );
  }

  @override
  Widget build(BuildContext context) {
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: CircularProgressIndicator(
                            color: AppColors.buttonColor),
                      ),
                    ],
                  );
                }
                if (snapshot.hasData) {
                  snapshot.data!.removeWhere(
                      (card) => card.pet.status?.normalizedName == "adopted");
                  if (snapshot.data!.isEmpty) {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Erro'),
                        content:
                            const Text('Não foi possível carregar a lista'),
                        actions: [
                          GoBackDialogLink(onPressed: () {
                            Get.back();
                          }),
                        ],
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '(${snapshot.data?.length ?? 0}) Pets disponíveis',
                                style: const TextStyle(fontSize: 20)),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.buttonColor),
                                fixedSize: MaterialStateProperty.all(
                                  const Size(150, 50),
                                ),
                                // alignment: center,
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10),
                                ),
                              ),
                              onPressed: () {
                                _modalBottomSheetConfig(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Filtrar",
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    AppSvgs.filterIcon,
                                    height: 40,
                                    width: 40,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      PetList(title: listTitle, children: snapshot.data!),
                    ],
                  );
                } else {
                  if (snapshot.hasError) {
                    Get.snackbar('Error', snapshot.error.toString());
                  }
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetConfig(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            height: MediaQuery.of(context).size.height * 0.85,
            child: const PetFilter(),
          ),
        );
      },
    );
  }
}
