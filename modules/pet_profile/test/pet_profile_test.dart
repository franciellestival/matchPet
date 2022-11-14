import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pet_profile/model/new_pet.dart';
import 'package:pet_profile/model/pet_profile.dart';

import 'package:pet_profile/pet_profile.dart';
import 'package:user_profile/model/user.dart';

import 'pet_data.dart';

void main() {
  NewPet petnew = NewPet.fromJson(jsonDecode(petSucess));

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
}
