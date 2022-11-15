import 'package:get/get.dart';
import 'package:pet_profile/model/new_pet.dart';
import 'package:pet_profile/repository/pet_repository.dart';

class PetController {
  static final PetRepository petRepository = Get.find(tag: 'pet_repository');

  static void registerPet(NewPet pet) async {
    try {
      await petRepository.addNewPetRequested(pet);
    } catch (e) {
      rethrow;
    }
  }
}
