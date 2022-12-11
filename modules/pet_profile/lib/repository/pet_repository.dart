import 'package:api_services/api_services.dart';
import 'package:pet_profile/models/new_pet.dart';
import 'package:pet_profile/models/pet_gender.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:pet_profile/models/pet_size.dart';
import 'package:pet_profile/models/pet_specie.dart';
import 'package:pet_profile/models/pet_status.dart';
import 'package:pet_profile/services/pet_services.dart';

class PetRepository {
  final PetServices petAPIServices;

  PetRepository(this.petAPIServices);

  Future<List<PetProfile>?> getPetsResquested() async {
    try {
      final response = await petAPIServices.getAllPets();
      return (response.data as List)
          .map((e) => PetProfile.fromJson(e))
          .toList();
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }

  Future<PetProfile?> getPetByID(int id) async {
    try {
      final response = await petAPIServices.getPetById(id);
      final pet = response?.data as PetProfile;
      return pet;
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }

  Future<String> addNewPetRequested(NewPet pet) async {
    try {
      final response = await petAPIServices.createPet(pet);
      return response.data["message"].toString();
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }

  Future<String> updatePetRequested(int id, NewPet pet) async {
    try {
      final response = await petAPIServices.updatePet(id, pet);
      return response!.data["message"].toString();
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }

  Future<void> deletePetRequested(int id) async {
    try {
      await petAPIServices.deletePet(id);
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }

  // Requests dos atributos de filtro
  //
  Future<List<PetSpecie>> getSpecies() async {
    try {
      final response = await petAPIServices.getSpecies();
      final species =
          (response.data as List).map((e) => PetSpecie.fromJson(e)).toList();
      return species;
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }

  Future<List<PetSize>> getSizes() async {
    try {
      final response = await petAPIServices.getSizes();
      final sizes =
          (response.data as List).map((e) => PetSize.fromJson(e)).toList();
      return sizes;
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }

  Future<List<PetGender>> getGenders() async {
    try {
      final response = await petAPIServices.getGenders();
      final genders =
          (response.data as List).map((e) => PetGender.fromJson(e)).toList();
      return genders;
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }

  Future<List<PetStatus>> getStatus() async {
    try {
      final response = await petAPIServices.getStatus();
      final status =
          (response.data as List).map((e) => PetStatus.fromJson(e)).toList();
      return status;
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }

  Future<List<PetProfile>> getFilteredPets(Map<String, String> filters) async {
    try {
      final response = await petAPIServices.filterPets(filters);
      final list =
          (response.data as List).map((e) => PetProfile.fromJson(e)).toList();
      return list;
    } on DioError catch (e) {
      final error = APIExceptions.fromDioError(e);
      throw error;
    }
  }
}
