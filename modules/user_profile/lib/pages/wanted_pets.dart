import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_profile/controller/pet_controller.dart';

import 'package:theme/export_theme.dart';
import 'package:user_profile/controller/interest_controller.dart';
import 'package:user_profile/model/interest.dart';

import 'package:user_profile/widgets/adoption_info.dart';

class WantedPets extends GetView<InterestController> {
  final bool isMyWantedPets;
  final int loggedUserId;

  List<Interest> adoptionInterestList = [];

  WantedPets(
      {super.key, required this.isMyWantedPets, required this.loggedUserId});

  @override
  Widget build(BuildContext context) {
    Get.put(InterestController());

    return Scaffold(
      appBar: GenericAppBar(
          title: isMyWantedPets ? 'Meus futuros Pets' : 'Avaliar interessados'),
      backgroundColor: AppColors.primaryColor.withOpacity(0.9),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: FutureBuilder<List<AdoptionInfo>?>(
            future: isMyWantedPets
                ? _getMyInterestList()
                : _getInterestedAdoptersListTeste(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.toList(),
                );
              } else {
                if (snapshot.hasError) {
                  Get.snackbar('Error', snapshot.error.toString());
                }
                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.buttonColor))
                    : const Center(
                        child: Text(
                          'Você ainda não demonstrou interesse em adotar um pet :( ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<AdoptionInfo>?> _getMyInterestList() async {
    try {
      final interestList = await controller.getInterestByUser(loggedUserId);

      if (interestList.isNotEmpty) {
        return interestList
            .map((e) => AdoptionInfo(
                  adoptionModel: e,
                  isMyWantedPets: true,
                ))
            .toList();
      }
      return null;
    } catch (e) {
      Get.snackbar('Erro!', "Não foi possivel obter a lista de interesses.");
    }
    return null;
  }

  Future<List<AdoptionInfo>?> _getInterestedAdoptersListTeste() async {
    controller.isLoading.value = true;
    try {
      final myPetsList =
          await PetController.getFilteredPetsProfile({"userId": loggedUserId});

      if (myPetsList.isNotEmpty) {
        final list = await Future.wait(myPetsList
            .map((pet) async => await controller.getInterestByPet(pet.id!)));
        final adoptionInfo = list
            .expand(
                (interestList) => interestList.map((interest) => AdoptionInfo(
                      adoptionModel: interest,
                      isMyWantedPets: false,
                    )))
            .toList();
        return adoptionInfo;
      }
      controller.isLoading.value = false;
      return null;
    } catch (e) {
      Get.snackbar('Erro!', "Não foi possivel obter a lista de interesses.");
    }
    return null;
  }
}
