import 'package:user_profile/model/user_location.dart';

class NewUser {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? passwordConfirmation;
  UserLocation? location;

  NewUser(
      {this.name,
      this.phone,
      this.email,
      this.password,
      this.passwordConfirmation,
      this.location});

  factory NewUser.fromJson(Map<String, dynamic> json) => NewUser(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      location: UserLocation.fromJson(json['location']));

  Map<String, dynamic> toJson() => {
        "user": {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
        "location": location?.toJson()
      };

  @override
  String toString() {
    return "NewUser(Name: $name, Phone: $phone, Email: $email, Password: $password, Password_Confirmation: $passwordConfirmation, Location: ${location.toString()}";
  }
}
