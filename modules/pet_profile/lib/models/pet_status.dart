import 'dart:convert';

class PetStatus {
  int? id;
  String? displayName;
  String? normalizedName;
  DateTime? createdAt;
  DateTime? updatedAt;

  PetStatus({
    this.id,
    this.displayName,
    this.normalizedName,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'PetStatus(id: $id, displayName: $displayName, normalizedName: $normalizedName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory PetStatus.fromMap(Map<String, dynamic> data) => PetStatus(
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

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PetStatus].
  factory PetStatus.fromJson(String data) {
    return PetStatus.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PetStatus] to a JSON string.
  String toJson() => json.encode(toMap());
}
