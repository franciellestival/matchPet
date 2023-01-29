// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pet_profile/models/pet_profile.dart';
import 'package:user_profile/model/user.dart';

class Interest {
  int? id;
  User? interestedUser;
  PetProfile? pet;
  bool? accepted;

  Interest({
    this.id,
    this.interestedUser,
    this.pet,
    this.accepted,
  });

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        id: json["id"],
        interestedUser: User.fromJson(json["user"]),
        pet: PetProfile.fromJson(json["pet"]),
        accepted: ((json['accepted'] ?? 0) as int) == 0 ? false : true,
      );

  @override
  String toString() {
    return 'AdoptionModel(id: $id, interestedUser: $interestedUser, pet: $pet, accepted: $accepted)';
  }
}
