// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/model/user_location.dart';

enum Gender { male, female }

enum Size { small, medium, big }

enum Species { dog, cat, other }

enum Status { registered, available, adopted, missing, adoptionProcess }

class PetProfile {
  int? id;
  String? name;
  Species? species;
  Gender? gender;
  Size? size;
  Status? status;
  String? breed;
  int? age;
  double? weight;
  String? description;
  int? neutered;
  int? specialNeeds;
  String? photoUrl;
  User? owner;
  UserLocation? location;

  PetProfile({
    this.id,
    this.name,
    this.species,
    this.gender,
    this.size,
    this.status,
    this.breed,
    this.age,
    this.weight,
    this.description,
    this.neutered,
    this.specialNeeds,
    this.photoUrl,
    this.owner,
    this.location,
  });

  PetProfile.empty();

  factory PetProfile.fromJson(Map<String, dynamic> json) => PetProfile(
        id: json['id'],
        name: json['name'],
        species: Species.values
            .firstWhere((e) => describeEnum(e) == json['species']),
        gender:
            Gender.values.firstWhere((e) => describeEnum(e) == json['gender']),
        size: Size.values.firstWhere((e) => describeEnum(e) == json['size']),
        status:
            Status.values.firstWhere((e) => describeEnum(e) == json['status']),
        breed: json['breed'],
        age: json['age'],
        weight: json['weight'],
        description: json['description'],
        neutered: json['neutered'],
        specialNeeds: json['special_need'],
        photoUrl: json['photoUrl'],
        //owner: User.fromJson(json['owner']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "species": species.toString().split('.').last,
        "gender": gender.toString().split('.').last,
        "size": size.toString().split('.').last,
        "status": status.toString().split('.').last,
        "breed": breed,
        "age": age,
        "weight": weight,
        "description": description,
        "neutered": neutered,
        "specialNeeds": specialNeeds,
        "photoUrl": photoUrl,
        //"owner": owner?.toJson(),
      };
}
