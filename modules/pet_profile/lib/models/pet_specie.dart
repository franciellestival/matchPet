import 'dart:convert';

class PetSpecie {
  int? id;
  String? displayName;
  String? normalizedName;
  DateTime? createdAt;
  DateTime? updatedAt;

  PetSpecie({
    this.id,
    this.displayName,
    this.normalizedName,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Specie(id: $id, displayName: $displayName, normalizedName: $normalizedName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory PetSpecie.fromMap(Map<String, dynamic> data) => PetSpecie(
        id: data['id'] as int?,
        displayName: data['display_name'] as String?,
        normalizedName: data['normalized_name'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'display_name': displayName,
        'normalized_name': normalizedName,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  factory PetSpecie.fromJson(String data) {
    return PetSpecie.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}