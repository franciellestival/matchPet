import 'dart:core';

import 'package:get/get.dart';
import 'package:pet_profile/model/new_pet.dart';
import 'package:pet_profile/model/pet_profile.dart';
import 'package:pet_profile/repository/pet_repository.dart';
import 'package:pet_profile/widgets/pet_card.dart';

class PetController {
  static Future<void> registerPet(NewPet pet) async {
    try {
      // final PetRepository petRepository = Get.find(tag: 'pet_repository');
      final PetRepository petRepository = Get.find();
      await petRepository.addNewPetRequested(pet);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PetCard>> getAllPets() async {
    final List<PetCard> cardsList = [];
    try {
      final PetRepository petRepository = Get.find();
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
