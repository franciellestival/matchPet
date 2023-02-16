import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/pages/missing_pet_page.dart';
import 'package:pet_profile/pages/pet_list_page.dart';

import 'package:pet_profile/pages/pet_register_page.dart';
import 'package:theme/export_theme.dart';
import 'package:user_profile/controller/user_controller.dart';
import 'package:user_profile/model/token.dart';
import 'package:user_profile/model/user.dart';

import 'package:user_profile/pages/status_page.dart';
import 'package:pet_profile/pages/favorites_page.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;

  CustomBottomNavBar({super.key, this.selectedIndex = 0});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  static const verticalPadding = 4.0;
  int _selectedIndex = 0;

  List<Widget> _pages = <Widget>[
    PetListPage(),
    FavoritesPage(),
    PetRegisterPage(),
    MissingPetPage(),
    StatusPage()
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.sync(() => _logInUser());
    return Scaffold(
      body: Center(child: _pages.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryLightColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.buttonColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.pawIcon,
                height: 30,
              ),
            ),
            label: 'Home',
            activeIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.pawIcon,
                height: 30,
                color: AppColors.buttonColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.heartIcon,
                height: 30,
              ),
            ),
            label: 'Favoritos',
            activeIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.heartIcon,
                height: 30,
                color: AppColors.buttonColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.plusIcon,
                height: 30,
              ),
            ),
            label: 'Cadastro',
            activeIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.plusIcon,
                color: AppColors.buttonColor,
                height: 30,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.disappearedIcon,
                height: 30,
              ),
            ),
            label: 'Desaparecidos',
            activeIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.disappearedIcon,
                height: 30,
                color: AppColors.buttonColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.userIcon,
                height: 30,
              ),
            ),
            label: 'Perfil',
            activeIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: SvgPicture.asset(
                AppSvgs.userIcon,
                height: 30,
                color: AppColors.buttonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logInUser() async {
    if (!Get.isRegistered<User>(tag: "loggedInUser")) {
      Token userToken = Get.find<Token>(tag: "userToken");
      User? user = await UserController.getLoggedUserData(userToken);
      if (user == null) {
        Get.offAllNamed(Routes.initialRoute);
        Get.snackbar('Erro!', 'Usuário inválido!');
      } else {
        Get.put<User>(user, tag: "loggedInUser", permanent: true);
      }
    }
    if (Get.isRegistered<ImageController>()) {
      Get.delete<ImageController>();
    }
  }
}
