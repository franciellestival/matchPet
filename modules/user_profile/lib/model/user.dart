import 'package:user_profile/model/user_location.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  UserLocation? location;
  String? token;

  User({this.id, this.name, this.phone, this.email, this.location, this.token});

  User.empty();

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        location: UserLocation.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "location": location?.toJson()
      };
}
