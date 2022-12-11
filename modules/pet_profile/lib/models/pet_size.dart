// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PetSize {
  int? id;
  String? displayName;
  String? normalizedName;

  PetSize({this.id, this.displayName, this.normalizedName});

  factory PetSize.fromJson(Map<String, dynamic> json) => PetSize(
      id: json['id'] as int?,
      displayName: json['display_name'] as String?,
      normalizedName: json['normalized_name'] as String?);

  factory PetSize.fromMap(Map<String, dynamic> data) => PetSize(
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
      'PetSize(id: $id, displayName: $displayName, normalizedName: $normalizedName)';
}
