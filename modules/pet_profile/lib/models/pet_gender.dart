import 'dart:convert';

class PetGender {
  int? id;
  String? displayName;
  String? normalizedName;

  PetGender({
    this.id,
    this.displayName,
    this.normalizedName,
  });

  factory PetGender.fromJson(Map<String, dynamic> data) => PetGender(
      id: data['id'] as int?,
      displayName: data['display_name'] as String?,
      normalizedName: data['normalized_name'] as String?);

  factory PetGender.fromMap(Map<String, dynamic> data) => PetGender(
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
      'PetGender(id: $id, displayName: $displayName, normalizedName: $normalizedName)';
}
