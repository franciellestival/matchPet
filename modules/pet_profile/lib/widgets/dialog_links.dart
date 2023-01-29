import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';

import 'package:theme/export_theme.dart';

class GoHomeDialogLink extends StatelessWidget {
  const GoHomeDialogLink({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.offNamed(Routes.home);
      },
      child: Text(
        'Ir para a Home',
        style: _linkTextStyle(),
      ),
    );
  }
}

class GoBackDialogLink extends StatelessWidget {
  const GoBackDialogLink({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        'Voltar',
        style: _linkTextStyle(),
      ),
    );
  }
}

class ConfirmAdoptionLink extends StatelessWidget {
  const ConfirmAdoptionLink({super.key, required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed as void Function(),
      child: Text(
        'Confirmar Adoção',
        style: _linkTextStyle(),
      ),
    );
  }
}

TextStyle _linkTextStyle() {
  return const TextStyle(
    color: AppColors.buttonColor,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
}
