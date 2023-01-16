// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pet_profile/models/pet_gender.dart';
import 'package:pet_profile/models/pet_size.dart';
import 'package:pet_profile/models/pet_specie.dart';
import 'package:pet_profile/models/pet_status.dart';
import 'package:user_profile/model/user.dart';
import 'package:user_profile/model/user_location.dart';

class PetProfile {
  int? id;
  String? name;
  PetSpecie? specie;
  PetGender? gender;
  PetSize? size;
  PetStatus? status;
  String? breed;
  int? age;
  double? weight;
  String? description;
  bool? neutered;
  bool? specialNeeds;
  String? photoUrl;
  UserLocation? location;
  User? owner;
  double distanceBetween = 0;

  PetProfile({
    this.id,
    this.name,
    this.specie,
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
    this.location,
    this.owner,
  });

  PetProfile.empty();

  factory PetProfile.fromJson(Map<String, dynamic> json) => PetProfile(
        id: json['id'],
        name: json['name'],
        specie: PetSpecie.fromJson(json['specie']),
        gender: PetGender.fromJson(json['gender']),
        size: PetSize.fromJson(json['size']),
        status: PetStatus.fromJson(json['status']),
        breed: json['breed'],
        age: json['age'],
        weight: json['weight'],
        description: json['description'],
        neutered: ((json['neutered'] ?? 0) as int) == 0 ? false : true,
        specialNeeds: ((json['special_need'] ?? 0) as int) == 0 ? false : true,
        photoUrl: json['photoUrl'],
        location: UserLocation.fromJson(json['location']),
        owner: User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "specie": specie!.toJson(),
        "gender": gender!.toJson(),
        "size": size!.toJson(),
        "status": status!.toJson(),
        "breed": breed,
        "age": age,
        "weight": weight,
        "description": description,
        "neutered": neutered,
        "special_need": specialNeeds,
        "photoUrl": photoUrl,
        "location": location!.toJson(),
        "user": owner!.toJson(),
      };

  @override
  String toString() {
    return 'PetProfile(id: $id, name: $name, specie: $specie, gender: $gender, size: $size, status: $status, breed: $breed, age: $age, weight: $weight, description: $description, neutered: $neutered, specialNeeds: $specialNeeds, photoUrl: $photoUrl, location: ${location.toString()}, owner: ${owner.toString()})';
  }
}
