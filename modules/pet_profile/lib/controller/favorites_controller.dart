import 'package:get/get.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:user_profile/repository/user_repository.dart';

import '../widgets/pet_card.dart';
import 'pet_controller.dart';

class FavoritesController {
  static Future<List<PetCard>> getFavorites(int userId) async {
    try {
      final List<PetCard> favoritesList = [];
      final UserRepository userRepository = Get.find();

      //Pega os favoritos como uma lista
      final List<dynamic> list = await userRepository.getFavoritesByid(userId);
      //Mapeia a lista para uma lista de PetProfile e a ordena por distancia
      final petList = await PetController.sortPetsByDistance(
          list.map((e) => PetProfile.fromJson(e)).toList());
      //Finalmente mapeia para uma lista de petCards
      if (petList.isNotEmpty) {
        for (var pet in petList) {
          PetCard petCard = PetCard(
            pet: pet,
          );
          favoritesList.add(petCard);
        }
      }

      return favoritesList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addToFavorites(int userId, int petId) async {
    try {
      final UserRepository userRepository = Get.find();
      await userRepository.addPetToFavorites(userId, petId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> removeFromFavorites(int userId, int petId) async {
    try {
      final UserRepository userRepository = Get.find();
      await userRepository.removePetFromFavorites(userId, petId);
    } catch (e) {
      rethrow;
    }
  }
}
