import 'dart:convert';

import 'package:api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_profile/models/new_pet.dart';
import 'package:pet_profile/models/pet_profile.dart';

import 'pet_data.dart';

void main() {
  NewPet petnew = NewPet.fromJson(jsonDecode(newPet));

  test('New Pet from Json Parsing', () {
    expect(petnew.name, "Major");
  });

  test('New Pet PROFILE to Json Parsing', () {
    petnew.toJson();
  });

  test('Post Test', () async {
    final APIServices petApi = APIServices(Dio());
    var formData = FormData.fromMap({
      "name": "Laika",
      "species": 1,
      "gender": 2,
      "size": 2,
      "status": 1,
      "breed": "Vira Latas",
      "age": 4,
      "weight": 30.0,
      "description": "teste",
      "neutered": 1,
      "specialNeeds": 0,
      "lat": 0,
      "lng": 0,
      "adress": "Rua Fake"
    });

    final response = await petApi.post('/pet',
        data: formData,
        options: Options(headers: {
          "Authorization":
              "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyNX0.TJHjHaL_8mqEHecpBX3XXAQxSCQi_Gu_naWdXdU5UT0"
        }));

    debugPrint(response.toString());
  });

  test('Pet Profile parsing', () {
    final petFromApi = PetProfile.fromJson(jsonDecode(petSucess));
    expect(petFromApi.id, 9);
  });

  test('Get Pet Profiles of API', () async {
    final APIServices petApi = APIServices(Dio());
    final response = await petApi.get('/pet',
        options: Options(headers: {
          "Authorization":
              "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyNX0.TJHjHaL_8mqEHecpBX3XXAQxSCQi_Gu_naWdXdU5UT0"
        }));
    debugPrint(response.statusCode.toString());
  });
}
