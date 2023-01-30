import 'package:api_services/api_services.dart';
import 'package:get/get.dart' as getx;
import 'package:pet_profile/models/new_pet.dart';
import 'package:pet_profile/models/pet_profile.dart';
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

  Future<Response?> getPetById(int id) async {
    try {
      token = getx.Get.find(tag: "userToken");
      final Response response = await petApi.get("$_petEndpoint/$id",
          options: Options(headers: {"Authorization": token.token}));
      return response;
    } catch (e) {
      rethrow;
    }
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

  Future<Response?> updatePet(int id, NewPet pet) async {
    try {
      token = getx.Get.find(tag: "userToken");
      var data = pet.toJson();
      data.remove("photo");
      var formData = FormData.fromMap({
        ...data,
        if ((pet.photo ?? "").isNotEmpty)
          "photo": await MultipartFile.fromFile(pet.photo!, filename: pet.name)
      });
      final Response response = await petApi.patch("$_petEndpoint/$id",
          data: formData,
          options: Options(headers: {"Authorization": token.token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response?> deletePet(int id) async {
    try {
      token = getx.Get.find(tag: "userToken");
      final Response response = await petApi.delete("$_petEndpoint/$id",
          options: Options(headers: {"Authorization": token.token.toString()}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getSpecies() async {
    try {
      token = getx.Get.find(tag: "userToken");
      return await petApi.get("/species",
          options: Options(headers: {"Authorization": token.token}));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getSizes() async {
    try {
      token = getx.Get.find(tag: "userToken");
      return await petApi.get("/sizes",
          options: Options(headers: {"Authorization": token.token}));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getGenders() async {
    try {
      token = getx.Get.find(tag: "userToken");
      return await petApi.get("/genders",
          options: Options(headers: {"Authorization": token.token}));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getStatus() async {
    try {
      token = getx.Get.find(tag: "userToken");
      return await petApi.get("/status",
          options: Options(headers: {"Authorization": token.token}));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> filterPets(Map<String, dynamic> filters) async {
    try {
      token = getx.Get.find(tag: "userToken");
      final Response response = await petApi.get(_petEndpoint,
          queryParameters: filters,
          options: Options(headers: {"Authorization": token.token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updatePetStatus(PetProfile pet) async {
    try {
      token = getx.Get.find(tag: "userToken");
      final Response response = await petApi.patch("$_petEndpoint/${pet.id}",
          data: FormData.fromMap({
            "status": pet.status!.normalizedName,
            "user": pet.owner!.toJson(),
          }),
          options: Options(
            headers: {"Authorization": token.token},
          ));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
