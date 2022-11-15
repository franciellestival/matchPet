import 'package:api_services/api_services.dart';
import 'package:pet_profile/model/new_pet.dart';
import 'package:pet_profile/model/pet_profile.dart';
import 'package:pet_profile/services/pet_services.dart';

class PetRepository {
  final PetServices petAPIServices;

  PetRepository(this.petAPIServices);

  Future<List<PetProfile>?> getPetResquested() async {
    try {
      final response = await petAPIServices.getAllPets();
      return (response.data as List)
          .map((e) => PetProfile.fromJson(e))
          .toList();
    } on DioError catch (e) {
      final erro = APIExceptions.fromDioError(e);
      throw erro;
    }
  }

  Future<PetProfile?> getPetByID(int id) async {
    return null;
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

  Future<void> deletePetRequested(int id) async {}
}
