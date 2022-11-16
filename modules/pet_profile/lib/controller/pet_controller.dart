import 'dart:core';

import 'package:get/get.dart';
import 'package:pet_profile/model/new_pet.dart';
import 'package:pet_profile/model/pet_profile.dart';
import 'package:pet_profile/repository/pet_repository.dart';
import 'package:pet_profile/widgets/pet_card.dart';

class PetController {
  static final PetRepository petRepository = Get.find(tag: 'pet_repository');

  static void registerPet(NewPet pet) async {
    try {
      await petRepository.addNewPetRequested(pet);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PetCard>> getAllPets() async {
    final List<PetCard> cardsList = [];

    try {
      final List<PetProfile>? response = await petRepository.getPetResquested();

      if (response != null) {
        for (var pet in response) {
          PetCard petCard = PetCard(pet: pet);
          cardsList.add(petCard);
        }
      }
      return cardsList;
    } catch (e) {
      rethrow;
    }
  }
}
