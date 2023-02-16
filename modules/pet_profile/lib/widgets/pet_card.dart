// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:matchpet/routes/app_routes.dart';
import 'package:pet_profile/models/pet_profile.dart';
import 'package:theme/export_theme.dart';
import 'package:user_profile/model/user.dart';

import '../controller/favorites_controller.dart';

class PetCard extends StatelessWidget {
  RxBool? isFavorited;
  final PetProfile pet;

  PetCard({
    super.key,
    required this.pet,
    this.isFavorited,
  });

  @override
  Widget build(BuildContext context) {
    isFavorited ??= pet.isUserFavorite!.obs;

    final User loggedInUser = Get.find<User>(tag: "loggedInUser");
    bool isMyPet = (pet.owner!.id == loggedInUser.id!);

    return cardScaffold(
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: AppColors.buttonColor,
            width: 1,
          ),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                AppColors.black.withOpacity(0.3), BlendMode.darken),
            fit: BoxFit.cover,
            image: NetworkImage(pet.photoUrl ??
                'https://i.pinimg.com/originals/d8/9e/d9/d89ed96e3cda94aff64b574662a621b3.jpg'),
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            if (!isMyPet)
              Align(alignment: Alignment.topRight, child: favoriteIcon()),
            Positioned(bottom: 70, child: petName()),
            Positioned(bottom: 45, child: petInfo()),
            Positioned(bottom: 0, child: buildButton()),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    return Center(
      child: PrimaryButton(
        onTap: () {
          Get.toNamed(Routes.petDetailPage, arguments: pet);
        },
        backgroundColor: AppColors.buttonColor.withOpacity(0.8),
        text: 'Saiba Mais',
        padding: const EdgeInsets.all(1),
        height: 10,
        width: 160,
        fontSize: 15,
      ),
    );
  }

  Widget cardScaffold({
    required Widget child,
  }) {
    return Center(
      child: child,
    );
  }

  Widget petName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
            pet.gender?.id == 1 ? AppSvgs.maleIcon : AppSvgs.femaleIcon,
            color: AppColors.white,
            height: 24.0),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            pet.name ?? "Pet Teste",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.white,
              fontFamily: globalFontFamily,
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget petInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          AppSvgs.locationIcon,
          color: AppColors.white,
          height: 10,
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            '${pet.distanceBetween} km',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.white,
              fontFamily: globalFontFamily,
              fontSize: 15.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "${pet.age} ano ${pet.age! > 1 ? "s" : ""}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.white,
              fontFamily: globalFontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget favoriteIcon() {
    return GestureDetector(
      onTap: _onTapFavorite,
      child: CircleAvatar(
        backgroundColor: AppColors.white.withOpacity(0.5),
        child: Obx(() {
          return SvgPicture.asset(
            isFavorited!.value ? AppSvgs.heartIcon : AppSvgs.favoriteOutlined,
            height: 24.0,
            color: isFavorited!.value ? Colors.red : Colors.black,
          );
        }),
      ),
    );
  }

  Future<String?> _getPetCity(double? lat, double? lng) async {
    List<Placemark>? placemarks =
        await placemarkFromCoordinates(lat!, lng!, localeIdentifier: 'pt_BR');

    if (placemarks.isEmpty) {
      return null;
    }
    Placemark place = placemarks[0];
    final String city =
        '${place.subAdministrativeArea!.toString()}, ${place.administrativeArea!.toString()}';
    return city;
  }

  void _onTapFavorite() async {
    try {
      final User loggedInUser = Get.find<User>(tag: "loggedInUser");
      if (isFavorited!.value) {
        await FavoritesController.removeFromFavorites(
            loggedInUser.id!, pet.id!);
        isFavorited!.value = false;
      } else {
        await FavoritesController.addToFavorites(loggedInUser.id!, pet.id!);
        isFavorited!.value = true;
      }
    } catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace);
      Get.snackbar(
          'Erro!', 'Erro ao mudar o status de favorito do pet ${pet.name}!');
    }
  }
}
