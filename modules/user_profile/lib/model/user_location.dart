class UserLocation {
  int? id;
  double? lat;
  double? lng;
  String? address;

  UserLocation({
    this.id,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
      id: json["id"] as int?,
      lat: json["lat"] as double?,
      lng: json["lng"] as double?,
      address: json["address"] as String?);

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "address": address,
      };
}
