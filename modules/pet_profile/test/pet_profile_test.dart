import 'dart:convert';
import 'dart:math';

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
  NewPet petnew = NewPet.fromJson(jsonDecode(newPet));

  test('New Pet from Json Parsing', () {
    expect(petnew.name, "Major");
  });

  test('Pet PROFILE to Json Parsing', () {
    petnew.toJson();
  });

  test('Another Post Test', () async {
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
  });
}
