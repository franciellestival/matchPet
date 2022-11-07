import 'package:location/location.dart';
import 'package:user_profile/di/service_locator.dart';
import 'package:user_profile/repository/user_repository.dart';

import '../model/new_user.dart';
import '../model/user_location.dart';

class SignUp {
  static void signUpUser(String name, String phone, String email,
      String password, String passwordConfirmation) async {
    try {
      Location location = Location();
      final locationData = await location.getLocation();
      NewUser user = NewUser(
          name: name,
          phone: phone,
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
          location: UserLocation(
              lat: locationData.latitude,
              lng: locationData.longitude,
              address: "Rua Teste, 123"));
      final userRepository = locator.get<UserRepository>();
      await userRepository.addNewUserRequested(user);
    } catch (e) {
      rethrow;
    }
  }
}


//Requisita permissão de acesso para o usuário
// Future<LocationData?> _getUserLocation() async {
//   Location location = Location();
//   bool serviceEnabled;
//   PermissionStatus permissionGranted;
//   LocationData locationData;

//   serviceEnabled = await location.serviceEnabled();
//   if (!serviceEnabled) {
//     serviceEnabled = await location.requestService();
//     if (!serviceEnabled) {
//       log("INFO: Serviço de GPS nao ativado.");
//       return null;
//     }
//   }
//   permissionGranted = await location.hasPermission();
//   if (permissionGranted == PermissionStatus.denied) {
//     permissionGranted = await location.requestPermission();
//     if (permissionGranted != PermissionStatus.granted) {
//       log("INFO: Permissão do uso de GPS nao concedida.");
//       return null;
//     }
//   }
//   log("INFO: $permissionGranted");

//   locationData = await location.getLocation();
//   return locationData;
// }

// //Função de Cadastro do usuário, retornando um User cadastrado e logado
//   Future<User?> _signUpUser() async {
//     LocationData? locationData;

//     locationData = await _getUserLocation();

//     if (locationData == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Erro ao requisitar localização")));
//       return null;
//     }

//     if (_formKey.currentState!.validate()) {
//       NewUser newUser = NewUser(
//           name: _nameController.text,
//           phone: _phoneController.text,
//           email: _emailController.text,
//           password: _pwController.text,
//           passwordConfirmation: _pwConfirmationController.text,
//           location: UserLocation(
//               lat: locationData.latitude,
//               lng: locationData.longitude,
//               address: "Rua Teste, 123"));
//       try {
//         final
//         await APIUserServices().saveUser(newUser);
//         Get.offAndToNamed(Routes.statusRoute, arguments: newUser);
//         return newUser;
//       } catch (e) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(e.toString())));
//       }
//     }
//     return null;
//   }