// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:user_profile/model/user.dart';

enum Gender { male, female }

enum Size { small, medium, big }

enum Species { dog, cat, other }

enum Status { registered, available, adopted, missing, adoptionProcess }

class NewPet {
  final String? name;
  final Species? species;
  final Gender? gender;
  final Size? size;
  final Status? status;
  final String? breed;
  final int? age;
  final double? weight;
  final String? description;
  final int? neutered;
  final int? specialNeeds;
  final double? lat;
  final double? lng;
  final String? adress;
  final String? photoUrl;

  NewPet(
      {this.name,
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
      this.lat,
      this.lng,
      this.adress,
      this.photoUrl});

  factory NewPet.fromJson(Map<String, dynamic> json) => NewPet(
        name: json['name'] ?? '',
        species: Species.values
            .firstWhere((e) => describeEnum(e) == json['species']),
        gender:
            Gender.values.firstWhere((e) => describeEnum(e) == json['gender']),
        size: Size.values.firstWhere((e) => describeEnum(e) == json['size']),
        status:
            Status.values.firstWhere((e) => describeEnum(e) == json['status']),
        breed: json['breed'] ?? '',
        age: json['age'] ?? 0,
        weight: json['weight'] ?? 0.0,
        description: json['description'] ?? '',
        neutered: json['neutered'] ?? 0,
        specialNeeds: json['special_need'] ?? 0,
        lat: json['location']['lat'] ?? 0,
        lng: json['location']['long'] ?? 0,
        adress: json['location']['address'] ?? '',
        photoUrl: json['photoUrl'] ?? '',
      );

  Map<String, dynamic> toJson() => {
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
      };
}
