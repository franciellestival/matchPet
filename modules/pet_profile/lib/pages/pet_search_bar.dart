import 'package:flutter/material.dart';

import 'package:theme/export_theme.dart';

class PetSearchBar extends StatelessWidget {
  PetSearchBar({super.key});

  TextEditingController inputSearch = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FormInputBox(
      hintText: 'Pesquisa',
      controller: inputSearch,
      backgroundColor: AppColors.primaryColor,
      suffixIcon: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          AppSvgs.searchIcon,
          height: 20,
        ),
      ),
    );
  }
}
