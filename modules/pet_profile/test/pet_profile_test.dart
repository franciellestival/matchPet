import 'dart:convert';

import 'package:api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_profile/model/new_pet.dart';
import 'package:pet_profile/model/pet_profile.dart';

import 'package:pet_profile/pet_profile.dart';
import 'package:pet_profile/services/pet_services.dart';
import 'package:user_profile/model/user.dart';

import 'pet_data.dart';

void main() {
  NewPet petnew = NewPet.fromJson(jsonDecode(petSucess));
  final api = PetServices(petApi: APIServices(Dio()));

  test('Pet From Json Sucess Parsing', () {
    final petTest = NewPet.fromJson(jsonDecode(petSucess));
    expect(petTest.gender, Gender.male);
  });
  test('Pet to Json Parsing', () {
    print(petnew.toJson());
  });
  test('Pet PROFILE to Json Parsing', () {
    //final petTest = PetProfile.fromJson(jsonDecode(petSucess));
  });

  test('Api Test', () async {
    try {
      final response = await api.getAllPets();
      debugPrint(response.data.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  test('Post Test', () async {
    try {
      final response = await api.createPet(petnew);
      print(response.statusCode);
      debugPrint(response.data.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  });
}

//     try {
//       final login = LoginService(apiClient: APIServices(Dio()));
//       final response = await login.login("teste_fe22@email.com", "teste123");
//       debugPrint(response.data.toString());
//     } catch (e) {
//       debugPrint(e.toString());
//     }