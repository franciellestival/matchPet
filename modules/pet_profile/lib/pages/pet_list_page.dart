import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_profile/controller/pet_controller.dart';
import 'package:pet_profile/pages/pet_filter_modal.dart';

import 'package:pet_profile/widgets/pet_card.dart';
import 'package:pet_profile/widgets/pet_list.dart';
import 'package:theme/export_theme.dart';
import 'package:user_profile/model/user_location.dart';
import 'package:user_profile/repository/user_repository.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  final String listTitle = 'Todos os Pets';

  Future<List<PetCard>?> _getPetsList() async {
    try {
      UserRepository userRepository = Get.find<UserRepository>();
      return Future.sync(() async {
        UserLocation? location = await userRepository.getCurrentLocation();
        if (location != null) {
          return await PetController.getFilteredPets(
              {"distance": 10, "lat": location.lat, "lng": location.lng});
        } else {
          return await PetController.getAllPets();
        }
      });
    } catch (e) {
      // Get.snackbar('Erro!', e.toString());
      Get.snackbar('Erro!', "Não foi possivel obter a lista de Animais.");
    }
    return null;
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
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.buttonColor),
                fixedSize: MaterialStateProperty.all(
                  const Size(250, 50),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            FutureBuilder<List<PetCard>?>(
              future: _getPetsList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PetList(title: listTitle, children: snapshot.data!);
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
