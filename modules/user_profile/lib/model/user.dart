import 'package:user_profile/model/user_location.dart';

class User {
  int? id;
  String? fullName;
  String? phone;
  String? email;
  String? password;
  String? passwordConfirmation;
  UserLocation? location;
  String? token;

  User(
      {this.id,
      this.fullName,
      this.phone,
      this.email,
      this.password,
      this.passwordConfirmation,
      this.location,
      this.token});

  User.empty();

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["name"],
        email: json["email"],
        phone: json["phone"],
        location: UserLocation.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "user": {
          "name": fullName,
          "email": email,
          "phone": phone,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
        // "id": id,
        "location": location?.toJson(),
      };
}
