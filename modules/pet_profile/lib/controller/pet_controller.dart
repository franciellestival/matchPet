import 'dart:core';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pet_profile/models/new_pet.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:pet_profile/repository/pet_repository.dart';
import 'package:pet_profile/widgets/pet_card.dart';
import 'package:user_profile/model/user_location.dart';

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
      UserLocation? location = await _getCurrentLocation();
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

      NewPet newPet = NewPet(
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
      await petRepository.addNewPetRequested(newPet);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PetCard>> getAllPets() async {
    final List<PetCard> cardsList = [];
    try {
      final PetRepository petRepository = Get.find();
      final List<PetProfile>? response =
          await petRepository.getPetsResquested();
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

  static Future<List<String?>> status() async {
    try {
      final PetRepository petRepository = Get.find();
      final statusRequested = await petRepository.getStatus();
      var statusList = [...statusRequested.map((e) => e.displayName)];
      return statusList;
    } catch (e) {
      rethrow;
    }
  }
}

Future<UserLocation?> _getCurrentLocation() async {
  Position? position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  List<Placemark>? placemarks = await placemarkFromCoordinates(
      position.latitude, position.longitude,
      localeIdentifier: 'pt_BR');

  if (placemarks.isEmpty) {
    return null;
  }
  Placemark place = placemarks[0];
  final String address = place.street!.toString();
  final UserLocation userLocation = UserLocation(
      lat: position.latitude, lng: position.longitude, address: address);
  return userLocation;
}
