// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewPet {
  String? name;
  String? species;
  String? gender;
  String? size;
  String? status;
  String? breed;
  int? age;
  double? weight;
  String? description;
  bool? neutered;
  bool? specialNeeds;
  double? lat;
  double? lng;
  String? address;
  String? photo;

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
      this.address,
      this.photo});

  NewPet.empty();

  Map<String, dynamic> toJson() => {
        "name": name,
        "species": species,
        "gender": gender,
        "size": size,
        "status": status,
        "breed": breed,
        "age": age,
        "weight": weight,
        "description": description,
        "neutered": neutered,
        "specialNeeds": specialNeeds,
      };

  @override
  String toString() {
    return 'NewPet(name: $name, species: $species, gender: $gender, size: $size, status: $status, breed: $breed, age: $age, weight: $weight, description: $description, neutered: $neutered, specialNeeds: $specialNeeds, lat: $lat, lng: $lng, address: $address, photo: $photo)';
  }
}
