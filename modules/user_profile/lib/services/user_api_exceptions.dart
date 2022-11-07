class UserAPIExceptions implements Exception {
  late Map<String, List<String>> erros;

  UserAPIExceptions.mapFromJson(Map<String, dynamic> json) {
    erros = {};
    var novoJson = json["message"] as List;
    for (var element in novoJson) {
      element.forEach((key, value) {
        if (erros.containsKey(key)) {
          erros[key]?.add(value);
        } else {
          erros[key] = <String>[];
          erros[key]?.add(value);
        }
      });
    }
  }

  @override
  String toString() => 'UserAPIExceptions(erros: $erros)';
}

// {
//     "message": [
//         {
//             "password": "Password can't be blank"
//         },
//         {
//             "email": "Email address must be provided"
//         },
//         {
//             "email": "Email is invalid"
//         }
//     ]
// }

// {
//   email: [
//     "Email address must be provided",
//     "Email is invalid"
//   ],
//   password: [
//     "Password can't be blank"
//   ]
// }