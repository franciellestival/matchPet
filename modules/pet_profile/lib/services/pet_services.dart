import 'package:api_services/api_services.dart';
import 'package:get/get.dart' as getx;
import 'package:pet_profile/model/new_pet.dart';
import 'package:user_profile/model/token.dart';

class PetServices {
  static const String _petEndpoint = "/pet";
  final Token token = getx.Get.find(tag: "userToken");

  final APIServices petApi;

  PetServices({required this.petApi});

  Future<Response> createPet(NewPet pet) async {
    try {
      return await petApi.post(_petEndpoint,
          data: pet, options: Options(headers: {"Authorization": token.token}));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response?> getPetById() async {
    return null;
  }

  Future<Response> getAllPets() async {
    try {
      return await petApi.get(_petEndpoint,
          options: Options(headers: {"Authorization": token.token}));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response?> updatePet() async {
    return null;
  }

  Future<Response?> deletePet() async {
    return null;
  }
}
