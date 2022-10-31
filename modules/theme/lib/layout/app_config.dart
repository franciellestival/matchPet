import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFFAEACD);
  static const Color buttonColor = Color(0xFFEF8801);
  static const Color editTextColor = Color(0xFFFDF7EC);
  static Color hintTextColor = Colors.black.withOpacity(0.25);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color blueButton = Color(0xFF01AADD);
}

class AppRadius {
  static double editTextRadius = 10.0;
  static double buttonRadius = 10.0;
  static double cardRadius = 32.0;
  static double blueButtonRadius = 20.0;
}

class AppStrings {
  static String get emptyFieldMsg => 'Campo não pode ficar vazio';
  static String get registerButton => 'Registrar-se';
  static String get loginButton => 'Entrar';
  static String get saveButton => 'Salvar';
  static String get cancelButton => 'Cancelar';
}
