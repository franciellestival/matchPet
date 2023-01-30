import 'dart:core';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:pet_profile/models/new_pet.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:pet_profile/repository/pet_repository.dart';
import 'package:pet_profile/widgets/pet_card.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/model/user_location.dart';
import 'package:user_profile/repository/user_repository.dart';

import '../models/pet_status.dart';

class PetController {
  //Cadastra um novo pet de acordo com os parametros recebidos
  static Future<void> registerPet(
      String name,
      String species,
      String gender,
      String size,
      String status,
      String breed,
      int age,
      double weight,
      String description,
      bool neutered,
      bool specialNeed,
      String photoUrl) async {
    try {
      final PetRepository petRepository = Get.find();
      NewPet newPet = await _newPetInstance(name, species, gender, size, status,
          breed, age, weight, description, neutered, specialNeed, photoUrl);

      await petRepository.addNewPetRequested(newPet);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updatePet(
      int petId,
      String name,
      String species,
      String gender,
      String size,
      String status,
      String breed,
      int age,
      double weight,
      String description,
      bool neutered,
      bool specialNeed,
      String photoUrl) async {
    try {
      final PetRepository petRepository = Get.find();
      NewPet newPet = await _newPetInstance(name, species, gender, size, status,
          breed, age, weight, description, neutered, specialNeed, photoUrl);
      await petRepository.updatePetRequested(petId, newPet);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deletePet(int petId) async {
    try {
      final PetRepository petRepository = Get.find();
      await petRepository.deletePetRequested(petId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PetProfile>> sortPetsByDistance(
      List<PetProfile> petList) async {
    final UserRepository userRepository = Get.find();
    UserLocation? userLocation = await userRepository.getCurrentLocation();
    final List<PetProfile> sortedPetList = [];
    try {
      for (var pet in petList) {
        var distanceFromUser = (GeolocatorPlatform.instance.distanceBetween(
                    userLocation?.lat ?? 0,
                    userLocation?.lng ?? 0,
                    pet.location?.lat ?? 0,
                    pet.location?.lng ?? 0) /
                1000)
            .toStringAsFixed(2);
        pet.distanceBetween = double.parse(distanceFromUser);
        sortedPetList.add(pet);
      }

      sortedPetList
          .sort((a, b) => a.distanceBetween.compareTo(b.distanceBetween));
      return sortedPetList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PetCard>> getAllPets() async {
    final List<PetCard> cardsList = [];
    try {
      final PetRepository petRepository = Get.find();
      final List<PetProfile>? petProfileList =
          await petRepository.getPetsResquested();
      if (petProfileList != null) {
        final List<PetProfile> sortedPetProfileList =
            await sortPetsByDistance(petProfileList);

        if (sortedPetProfileList.isNotEmpty) {
          for (var pet in sortedPetProfileList) {
            PetCard petCard = PetCard(pet: pet);
            cardsList.add(petCard);
          }
        }
      }
      return cardsList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<PetProfile?> getPetByID(int id) async {
    try {
      final PetRepository petRepository = Get.find();
      return await petRepository.getPetByID(id);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PetCard>> getPetsByUser(User user) async {
    final List<PetCard> cardsList = [];
    Map<String, String> filter = {
      "userId": user.id.toString(),
    };
    try {
      final PetRepository petRepository = Get.find();
      List<PetProfile> response = await petRepository.getFilteredPets(filter);
      response = await sortPetsByDistance(response);
      for (var pet in response) {
        PetCard petCard = PetCard(pet: pet);
        cardsList.add(petCard);
      }
      return cardsList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PetCard>> getFilteredPets(
      Map<String, dynamic> filters) async {
    final List<PetCard> cardsList = [];

    try {
      final PetRepository petRepository = Get.find();
      final List<PetProfile> petProfileList =
          await petRepository.getFilteredPets(filters);

      final List<PetProfile> sortedPetProfileList =
          await sortPetsByDistance(petProfileList);

      if (sortedPetProfileList.isNotEmpty) {
        for (var pet in sortedPetProfileList) {
          PetCard petCard = PetCard(pet: pet);
          cardsList.add(petCard);
        }
      }

      return cardsList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PetProfile>> getFilteredPetsProfile(
      Map<String, dynamic> filters) async {
    try {
      final PetRepository petRepository = Get.find();

      final List<PetProfile> petProfileList =
          await petRepository.getFilteredPets(filters);

      return petProfileList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<String?>> genders() async {
    try {
      final PetRepository petRepository = Get.find();
      final gendersRequested = await petRepository.getGenders();
      var genderList = [...gendersRequested.map((e) => e.displayName)];
      return genderList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<String?>> species() async {
    try {
      final PetRepository petRepository = Get.find();
      final speciesRequested = await petRepository.getSpecies();
      var speciesList = [...speciesRequested.map((e) => e.displayName)];
      return speciesList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<String?>> sizes() async {
    try {
      final PetRepository petRepository = Get.find();
      final sizesRequested = await petRepository.getSizes();
      var sizesList = [...sizesRequested.map((e) => e.displayName)];
      return sizesList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<String?>> status({List<String>? only}) async {
    try {
      final PetRepository petRepository = Get.find();
      final statusRequested = await petRepository.getStatus();
      List<PetStatus> filteredStatus = List.from(statusRequested);
      //Se veio uma lista limitando os status, removemos os demais
      if (only != null) {
        filteredStatus.removeWhere((e) => !only.contains(e.normalizedName));
      }
      var statusList = [...filteredStatus.map((e) => e.displayName!)];
      return statusList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> changeAdoptionStatus(
      int interestedUserId, int petId) async {
    try {
      final UserRepository userRepository = Get.find<UserRepository>();
      final PetRepository petRepository = Get.find<PetRepository>();
      //Requisitamos o pet a partir do id
      PetProfile? pet = await getPetByID(petId);

      //Requisitamos o usuario a partir do id
      User? user = await userRepository.getUserById(interestedUserId);

      if ((pet != null) && (user != null)) {
        var statusList = await petRepository.getStatus();

        pet.owner = user;
        pet.status = statusList
            .firstWhere((element) => element.normalizedName == "adopted");

        await petRepository.updatePetStatus(pet);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> changeMissingStatus(int petId) async {
    //Requisitamos o pet a partir do id
    final PetRepository petRepository = Get.find<PetRepository>();

    PetProfile? pet = await getPetByID(petId);
    if (pet != null) {
      var statusList = await petRepository.getStatus();

      pet.status = statusList
          .firstWhere((element) => element.normalizedName == "missing");

      await petRepository.updatePetStatus(pet);
    }
  }
}

Future<NewPet> _newPetInstance(
    String name,
    String species,
    String gender,
    String size,
    String status,
    String breed,
    int age,
    double weight,
    String description,
    bool neutered,
    bool specialNeed,
    String photoUrl) async {
  try {
    final PetRepository petRepository = Get.find();
    final UserRepository userRepository = Get.find();

    UserLocation? location = await userRepository.getCurrentLocation();
    var speciesList = await petRepository.getSpecies();
    var gendersList = await petRepository.getGenders();
    var sizesList = await petRepository.getSizes();
    var statusList = await petRepository.getStatus();

    var specieMapped = speciesList
        .firstWhere((element) => element.displayName == species)
        .normalizedName;

    var genderMapped = gendersList
        .firstWhere((element) => element.displayName == gender)
        .normalizedName;

    var sizeMapped = sizesList
        .firstWhere((element) => element.displayName == size)
        .normalizedName;

    var statusMapped = statusList
        .firstWhere((element) => element.displayName == status)
        .normalizedName;

    return NewPet(
        name: name,
        species: specieMapped,
        gender: genderMapped,
        size: sizeMapped,
        status: statusMapped,
        breed: breed,
        age: age,
        weight: weight,
        description: description,
        neutered: neutered,
        specialNeed: specialNeed,
        photo: photoUrl,
        lat: location?.lat,
        lng: location?.lng,
        address: location?.address);
  } catch (e) {
    rethrow;
  }
}
