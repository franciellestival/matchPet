import 'package:api_services/api_services.dart';
import 'package:get/get.dart' as getx;
import 'package:pet_profile/model/new_pet.dart';
import 'package:user_profile/model/token.dart';

class PetServices {
  static const String _petEndpoint = "/pet";

  final APIServices petApi;

  late Token token;

  PetServices({required this.petApi});

  Future<Response> createPet(NewPet pet) async {
    token = getx.Get.find(tag: "userToken");
    var formData = FormData.fromMap({
      ...pet.toJson(),
      "photo": await MultipartFile.fromFile(pet.photo!, filename: pet.name)
    });
    try {
      final response = await petApi.post(_petEndpoint,
          data: formData,
          options: Options(headers: {"Authorization": token.token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response?> getPetById() async {
    return null;
  }

  Future<Response> getAllPets() async {
    try {
      token = getx.Get.find(tag: "userToken");
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
