import 'dart:convert';

class PetSpecie {
  int? id;
  String? displayName;
  String? normalizedName;

  PetSpecie({this.id, this.displayName, this.normalizedName});

  factory PetSpecie.fromJson(Map<String, dynamic> json) => PetSpecie(
      id: json['id'] as int?,
      displayName: json['display_name'] as String?,
      normalizedName: json['normalized_name'] as String?);

  factory PetSpecie.fromMap(Map<String, dynamic> data) => PetSpecie(
      id: data['id'] as int?,
      displayName: data['display_name'] as String?,
      normalizedName: data['normalized_name'] as String?);

  Map<String, dynamic> toMap() => {
        'id': id,
        'display_name': displayName,
        'normalized_name': normalizedName
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'PetSpecie(id: $id, displayName: $displayName, normalizedName: $normalizedName)';
}
