part of extensions;

extension ExtString on String {
  String get isValidPassword {
    if (length < 8) {
      return 'A senha deve ter ao menos 8 caracteres.';
    }
    var passwordRegex = RegExp(r'(?=.*[A-Z]{1,})');
    if (!passwordRegex.hasMatch(this)) {
      return 'A senha deve ter ao menos uma letra maiúscula';
    }

    passwordRegex = RegExp(r'(?=.*[!@#$&*()+-]{1,})');
    if (!passwordRegex.hasMatch(this)) {
      return 'A senha deve ter ao menos um caractere especial.';
    }
    passwordRegex = RegExp(r'(?=.*[0-9]{1,})');
    if (!passwordRegex.hasMatch(this)) {
      return 'A senha deve ter ao menos um dígito numérico.';
    }

    return '';
  }

  bool get isValidPhone {
    final passwordRegex =
        RegExp(r"^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$");
    return passwordRegex.hasMatch(this);
  }
}
