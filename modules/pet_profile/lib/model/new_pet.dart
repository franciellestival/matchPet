class NewPet {
  final String? name;
  final int? species;
  final int? gender;
  final int? size;
  final int? status;
  final String? breed;
  final int? age;
  final double? weight;
  final String? description;
  final int? neutered;
  final int? specialNeeds;
  final double? lat;
  final double? lng;
  final String? adress;

  NewPet({
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
    this.lat,
    this.lng,
    this.adress,
  });

  factory NewPet.fromJson(Map<String, dynamic> json) {
    return NewPet(
      name: json['name'] ?? '',
      species: json['species'],
      gender: json['gender'],
      size: json['size'],
      status: json['status'],
      breed: json['breed'] ?? '',
      age: json['age'],
      weight: json['weight'],
      description: json['description'] ?? '',
      neutered: json['neutered'],
      specialNeeds: json['special_need'],
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      adress: json['address'] ?? '',
    );
  }

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
}
