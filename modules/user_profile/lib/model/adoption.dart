// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pet_profile/models/pet_profile.dart';
import 'package:user_profile/model/user.dart';

class AdoptionModel {
  User? interestedUser;
  PetProfile? pet;
  bool? authorized;

  AdoptionModel({
    this.interestedUser,
    this.pet,
    this.authorized,
  });
}
